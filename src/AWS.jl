module AWS

using Compat: Compat, @something
using Base64
using Dates
using HTTP
using MbedTLS
using Mocking
using OrderedCollections: LittleDict, OrderedDict
using Retry
using Sockets
using URIs
using UUIDs: UUIDs
using XMLDict

export @service
export _merge
export AbstractAWSConfig, AWSConfig, AWSExceptions, AWSServices, Request
export ec2_instance_metadata, ec2_instance_region
export generate_service_url, global_aws_config, set_user_agent
export sign!, sign_aws2!, sign_aws4!
export JSONService, RestJSONService, RestXMLService, QueryService


const DEFAULT_REGION = "us-east-1"
const CUSTOM_ENDPOINTS = Dict("ses" => "email",
                            "detective" => "api.detective",
                            "execute-api" => "iot")

include(joinpath("utilities", "utilities.jl"))

include("AWSExceptions.jl")
include("AWSCredentials.jl")
include("AWSConfig.jl")
include("AWSMetadata.jl")

include(joinpath("utilities", "request.jl"))
include(joinpath("utilities", "sign.jl"))


using ..AWSExceptions
using ..AWSExceptions: AWSException

const user_agent = Ref("AWS.jl/1.0.0")
const aws_config = Ref{AbstractAWSConfig}()

"""
    global_aws_config()

Retrieve the global AWS configuration.
If one is not set, create one with default configuration options.

# Keywords
- `kwargs...`: AWSConfig kwargs to be passed along if the global configuration is not already set

# Returns
- `AWSConfig`: The global AWS configuration
"""
function global_aws_config(; kwargs...)
    if !isassigned(aws_config) || !isempty(kwargs)
        aws_config[] = AWSConfig(; kwargs...)
    end

    return aws_config[]
end


"""
    global_aws_config(config::AbstractAWSConfig)

Set the global AWSConfig.

# Arguments
- `config::AWSConfig`: The AWSConfig to set in the global state

# Returns
- `AWSConfig`: Global AWSConfig
"""
function global_aws_config(config::AbstractAWSConfig)
    return aws_config[] = config
end


"""
    set_user_agent(new_user_agent::String)

Set the global user agent when making HTTP requests.

# Arguments
- `new_user_agent::String`: User agent to set when making HTTP requests

# Return
- `String`: The global user agent
"""
set_user_agent(new_user_agent::String) = return user_agent[] = new_user_agent


"""
    macro service(module_name::Symbol)

Include a high-level service wrapper based off of the module_name parameter.

When calling the macro you cannot match the predefined constant for the lowl level API.
The low level API constants are named in all lowercase, and spaces replaced with underscores.

Examples:
```julia
using AWS.AWSServices: secrets_manager
using AWS: @service

# This matches the constant and will error!
@service secrets_manager
> ERROR: cannot assign a value to variable AWSServices.secrets_manager from module Main

# This does NOT match the filename structure and will error!
@service secretsmanager
> ERROR: could not open file /.julia/dev/AWS.jl/src/services/secretsmanager.jl

# All of the examples below are valid!
@service Secrets_Manager
@service SECRETS_MANAGER
@service sECRETS_MANAGER
```

# Arguments
- `module_name::Symbol`: Name of the service to include high-level API wrappers in your namespace

# Return
- `Expression`: Base.include() call to introduce the high-level service API wrapper functions in your namespace
"""
macro service(module_name::Symbol)
    service_name = joinpath(@__DIR__, "services", lowercase(string(module_name)) * ".jl")

    return Expr(:toplevel,
    :(module($(esc(module_name)))
        Base.include($(esc(module_name)), $(esc(service_name)))
     end))
end

struct RestXMLService
    name::String
    api_version::String
end

struct QueryService
    name::String
    api_version::String
end

struct JSONService
    name::String
    api_version::String

    json_version::String
    target::String
end

struct RestJSONService
    name::String
    api_version::String

    service_specific_headers::LittleDict{String, String}
end

RestJSONService(name::String, api_version::String) = RestJSONService(name, api_version, LittleDict{String, String}())

# Needs to be included after the definition of struct otherwise it cannot find them
include("AWSServices.jl")


function generate_service_url(aws::AbstractAWSConfig, service::String, resource::String)
    SERVICE_HOST = "amazonaws.com"
    reg = region(aws)

    regionless_services = ("iam", "route53")

    if service in regionless_services || (service == "sdb" && reg == DEFAULT_REGION)
        reg = ""
    end
    if haskey(CUSTOM_ENDPOINTS, service)
        return string("https://", CUSTOM_ENDPOINTS[service], ".", isempty(reg) ? "" : "$reg.", SERVICE_HOST, resource)
    else
        return string("https://", service, ".", isempty(reg) ? "" : "$reg.", SERVICE_HOST, resource)
    end
end



"""
    (service::RestXMLService)(
        request_method::String, request_uri::String, args::AbstractDict{String, <:Any}=Dict{String, String}();
        aws::AbstractAWSConfig=aws_config
    )

Perform a RestXML request to AWS.

# Arguments
- `request_method::String`: RESTful request type, e.g.: `GET`, `HEAD`, `PUT`, etc.
- `request_uri::String`: AWS URI for the endpoint
- `args::AbstractDict{String, <:Any}`: Additional arguments to be included in the request

# Keywords
- `aws::AbstractAWSConfig`: AWSConfig containing credentials and other information for fulfilling the request, default value is the global configuration

# Returns
- `Tuple or Dict`: If `return_headers` is passed in through `args` a Tuple containing the Headers and Response will be returned, otherwise just a Dict
"""
function (service::RestXMLService)(
    request_method::String, request_uri::String, args::AbstractDict{String, <:Any}=Dict{String, Any}();
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return_headers = _pop!(args, "return_headers", false)

    request = Request(;
        _extract_common_kw_args(service, args)...,
        request_method=request_method,
        content=_pop!(args, "body", ""),
    )

    if request.service == "s3"
        request_uri = _clean_s3_uri(request_uri)
    end
    request.resource = _generate_rest_resource(request_uri, args)
    query_str = HTTP.escapeuri(args)

    if !isempty(query_str)
        if occursin('?', request.resource)
            request.resource *= "&$query_str"
        else
            request.resource *= "?$query_str"
        end
    end

    request.url = generate_service_url(aws_config, request.service, request.resource)

    return submit_request(aws_config, request; return_headers=return_headers)
end


"""
    (service::QueryService)(
        operation::String, args::AbstractDict{String, <:Any}=Dict{String, Any}();
        aws::AbstractAWSConfig=aws_config
    )

Perform a Query request to AWS.

# Arguments
- `operation::String`:
- `args::AbstractDict{String, <:Any}`: Additional arguments to be included in the request

# Keywords
- `aws::AbstractAWSConfig`: AWSConfig containing credentials and other information for fulfilling the request, default value is the global configuration

# Returns
- `Tuple or Dict`: If `return_headers` is passed in through `args` a Tuple containing the Headers and Response will be returned, otherwise just a Dict
"""
function (service::QueryService)(
    operation::String, args::AbstractDict{String, <:Any}=Dict{String, Any}();
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    POST_RESOURCE = "/"
    return_headers = _pop!(args, "return_headers", false)

    request = Request(;
        _extract_common_kw_args(service, args)...,
        resource=POST_RESOURCE,
        request_method="POST",
        url=generate_service_url(aws_config, service.name, POST_RESOURCE),
    )

    request.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"

    args["Action"] = operation
    args["Version"] = service.api_version
    request.content = HTTP.escapeuri(_flatten_query(service.name, args))

    return submit_request(aws_config, request; return_headers=return_headers)
end

"""
    (service::JSONService)(
        operation::String, args::AbstractDict{String, <:Any}=Dict{String, Any}();
        aws::AbstractAWSConfig=aws_config
    )

Perform a JSON request to AWS.

# Arguments
- `operation::String`: Name of the operation to perform
- `args::AbstractDict{String, <:Any}`: Additional arguments to be included in the request

# Keywords
- `aws::AbstractAWSConfig`: AWSConfig containing credentials and other information for fulfilling the request, default value is the global configuration

# Returns
- `Tuple or Dict`: If `return_headers` is passed in through `args` a Tuple containing the Headers and Response will be returned, otherwise just a Dict
"""
function (service::JSONService)(
    operation::String, args::AbstractDict{String, <:Any}=Dict{String, Any}();
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    POST_RESOURCE = "/"
    return_headers = _pop!(args, "return_headers", false)

    request = Request(;
        _extract_common_kw_args(service,args)...,
        resource=POST_RESOURCE,
        request_method="POST",
        content=json(args),
        url=generate_service_url(aws_config, service.name, POST_RESOURCE),
    )

    request.headers["Content-Type"] = "application/x-amz-json-$(service.json_version)"
    request.headers["X-Amz-Target"] = "$(service.target).$(operation)"

    return submit_request(aws_config, request; return_headers=return_headers)
end

"""
    (service::RestJSONService)(
        request_method::String, request_uri::String, args::AbstractDict{String, <:Any}=Dict{String, String}();
        aws::AbstractAWSConfig=aws_config
    )

Perform a RestJSON request to AWS.

# Arguments
- `request_method::String`: RESTful request type, e.g.: `GET`, `HEAD`, `PUT`, etc.
- `request_uri::String`: AWS URI for the endpoint
- `args::AbstractDict{String, <:Any}`: Additional arguments to be included in the request

# Keywords
- `aws::AbstractAWSConfig`: AWSConfig containing credentials and other information for fulfilling the request, default value is the global configuration

# Returns
- `Tuple or Dict`: If `return_headers` is passed in through `args` a Tuple containing the Headers and Response will be returned, otherwise just a Dict
"""
function (service::RestJSONService)(
    request_method::String, request_uri::String, args::AbstractDict{String, <:Any}=Dict{String, String}();
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return_headers = _pop!(args, "return_headers", false)

    request = Request(;
        _extract_common_kw_args(service, args)...,
        request_method=request_method,
        resource=_generate_rest_resource(request_uri, args),
    )

    request.url = generate_service_url(aws_config, request.service, request.resource)

    if !isempty(service.service_specific_headers)
        merge!(request.headers, service.service_specific_headers)
    end

    request.headers["Content-Type"] = "application/json"
    request.content = json(args)

    return submit_request(aws_config, request; return_headers=return_headers)
end

function __init__()
    DEFAULT_BACKEND[] = HTTPBackend()
    return nothing
end

end  # module AWS
