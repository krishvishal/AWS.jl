# This file is auto-generated by AWSMetadata.jl
using AWS
using AWS.AWSServices: servicediscovery
using AWS.Compat
using AWS.UUIDs

"""
    create_http_namespace(name)
    create_http_namespace(name, params::Dict{String,<:Any})

Creates an HTTP namespace. Service instances that you register using an HTTP namespace can
be discovered using a DiscoverInstances request but can't be discovered using DNS.  For the
current quota on the number of namespaces that you can create using the same AWS account,
see AWS Cloud Map quotas in the AWS Cloud Map Developer Guide.

# Arguments
- `name`: The name that you want to assign to this namespace.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"CreatorRequestId"`: A unique string that identifies the request and that allows failed
  CreateHttpNamespace requests to be retried without the risk of running the operation twice.
  CreatorRequestId can be any unique string, for example, a date/time stamp.
- `"Description"`: A description for the namespace.
- `"Tags"`: The tags to add to the namespace. Each tag consists of a key and an optional
  value that you define. Tags keys can be up to 128 characters in length, and tag values can
  be up to 256 characters in length.
"""
create_http_namespace(Name; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreateHttpNamespace", Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())); aws_config=aws_config)
create_http_namespace(Name, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreateHttpNamespace", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())), params)); aws_config=aws_config)

"""
    create_private_dns_namespace(name, vpc)
    create_private_dns_namespace(name, vpc, params::Dict{String,<:Any})

Creates a private namespace based on DNS, which is visible only inside a specified Amazon
VPC. The namespace defines your service naming scheme. For example, if you name your
namespace example.com and name your service backend, the resulting DNS name for the service
is backend.example.com. For the current quota on the number of namespaces that you can
create using the same AWS account, see AWS Cloud Map Limits in the AWS Cloud Map Developer
Guide.

# Arguments
- `name`: The name that you want to assign to this namespace. When you create a private DNS
  namespace, AWS Cloud Map automatically creates an Amazon Route 53 private hosted zone that
  has the same name as the namespace.
- `vpc`: The ID of the Amazon VPC that you want to associate the namespace with.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"CreatorRequestId"`: A unique string that identifies the request and that allows failed
  CreatePrivateDnsNamespace requests to be retried without the risk of running the operation
  twice. CreatorRequestId can be any unique string, for example, a date/timestamp.
- `"Description"`: A description for the namespace.
- `"Tags"`: The tags to add to the namespace. Each tag consists of a key and an optional
  value that you define. Tags keys can be up to 128 characters in length, and tag values can
  be up to 256 characters in length.
"""
create_private_dns_namespace(Name, Vpc; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreatePrivateDnsNamespace", Dict{String, Any}("Name"=>Name, "Vpc"=>Vpc, "CreatorRequestId"=>string(uuid4())); aws_config=aws_config)
create_private_dns_namespace(Name, Vpc, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreatePrivateDnsNamespace", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Name"=>Name, "Vpc"=>Vpc, "CreatorRequestId"=>string(uuid4())), params)); aws_config=aws_config)

"""
    create_public_dns_namespace(name)
    create_public_dns_namespace(name, params::Dict{String,<:Any})

Creates a public namespace based on DNS, which is visible on the internet. The namespace
defines your service naming scheme. For example, if you name your namespace example.com and
name your service backend, the resulting DNS name for the service is backend.example.com.
For the current quota on the number of namespaces that you can create using the same AWS
account, see AWS Cloud Map Limits in the AWS Cloud Map Developer Guide.

# Arguments
- `name`: The name that you want to assign to this namespace.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"CreatorRequestId"`: A unique string that identifies the request and that allows failed
  CreatePublicDnsNamespace requests to be retried without the risk of running the operation
  twice. CreatorRequestId can be any unique string, for example, a date/timestamp.
- `"Description"`: A description for the namespace.
- `"Tags"`: The tags to add to the namespace. Each tag consists of a key and an optional
  value that you define. Tags keys can be up to 128 characters in length, and tag values can
  be up to 256 characters in length.
"""
create_public_dns_namespace(Name; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreatePublicDnsNamespace", Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())); aws_config=aws_config)
create_public_dns_namespace(Name, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreatePublicDnsNamespace", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())), params)); aws_config=aws_config)

"""
    create_service(name)
    create_service(name, params::Dict{String,<:Any})

Creates a service, which defines the configuration for the following entities:   For public
and private DNS namespaces, one of the following combinations of DNS records in Amazon
Route 53:    A     AAAA     A and AAAA     SRV     CNAME      Optionally, a health check
After you create the service, you can submit a RegisterInstance request, and AWS Cloud Map
uses the values in the configuration to create the specified entities. For the current
quota on the number of instances that you can register using the same namespace and using
the same service, see AWS Cloud Map Limits in the AWS Cloud Map Developer Guide.

# Arguments
- `name`: The name that you want to assign to the service. If you want AWS Cloud Map to
  create an SRV record when you register an instance and you're using a system that requires
  a specific SRV format, such as HAProxy, specify the following for Name:   Start the name
  with an underscore (_), such as _exampleservice.   End the name with ._protocol, such as
  ._tcp.   When you register an instance, AWS Cloud Map creates an SRV record and assigns a
  name to the record by concatenating the service name and the namespace name, for example:
  _exampleservice._tcp.example.com   For services that are accessible by DNS queries, you
  can't create multiple services with names that differ only by case (such as EXAMPLE and
  example). Otherwise, these services have the same DNS name and can't be distinguished.
  However, if you use a namespace that's only accessible by API calls, then you can create
  services that with names that differ only by case.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"CreatorRequestId"`: A unique string that identifies the request and that allows failed
  CreateService requests to be retried without the risk of running the operation twice.
  CreatorRequestId can be any unique string, for example, a date/timestamp.
- `"Description"`: A description for the service.
- `"DnsConfig"`: A complex type that contains information about the Amazon Route 53
  records that you want AWS Cloud Map to create when you register an instance.
- `"HealthCheckConfig"`:  Public DNS and HTTP namespaces only. A complex type that contains
  settings for an optional Route 53 health check. If you specify settings for a health
  check, AWS Cloud Map associates the health check with all the Route 53 DNS records that
  you specify in DnsConfig.  If you specify a health check configuration, you can specify
  either HealthCheckCustomConfig or HealthCheckConfig but not both.  For information about
  the charges for health checks, see AWS Cloud Map Pricing.
- `"HealthCheckCustomConfig"`: A complex type that contains information about an optional
  custom health check.  If you specify a health check configuration, you can specify either
  HealthCheckCustomConfig or HealthCheckConfig but not both.  You can't add, update, or
  delete a HealthCheckCustomConfig configuration from an existing service.
- `"NamespaceId"`: The ID of the namespace that you want to use to create the service. The
  namespace ID must be specified, but it can be specified either here or in the DnsConfig
  object.
- `"Tags"`: The tags to add to the service. Each tag consists of a key and an optional
  value that you define. Tags keys can be up to 128 characters in length, and tag values can
  be up to 256 characters in length.
- `"Type"`: If present, specifies that the service instances are only discoverable using
  the DiscoverInstances API operation. No DNS records will be registered for the service
  instances. The only valid value is HTTP.
"""
create_service(Name; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreateService", Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())); aws_config=aws_config)
create_service(Name, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("CreateService", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Name"=>Name, "CreatorRequestId"=>string(uuid4())), params)); aws_config=aws_config)

"""
    delete_namespace(id)
    delete_namespace(id, params::Dict{String,<:Any})

Deletes a namespace from the current account. If the namespace still contains one or more
services, the request fails.

# Arguments
- `id`: The ID of the namespace that you want to delete.

"""
delete_namespace(Id; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeleteNamespace", Dict{String, Any}("Id"=>Id); aws_config=aws_config)
delete_namespace(Id, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeleteNamespace", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Id"=>Id), params)); aws_config=aws_config)

"""
    delete_service(id)
    delete_service(id, params::Dict{String,<:Any})

Deletes a specified service. If the service still contains one or more registered
instances, the request fails.

# Arguments
- `id`: The ID of the service that you want to delete.

"""
delete_service(Id; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeleteService", Dict{String, Any}("Id"=>Id); aws_config=aws_config)
delete_service(Id, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeleteService", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Id"=>Id), params)); aws_config=aws_config)

"""
    deregister_instance(instance_id, service_id)
    deregister_instance(instance_id, service_id, params::Dict{String,<:Any})

Deletes the Amazon Route 53 DNS records and health check, if any, that AWS Cloud Map
created for the specified instance.

# Arguments
- `instance_id`: The value that you specified for Id in the RegisterInstance request.
- `service_id`: The ID of the service that the instance is associated with.

"""
deregister_instance(InstanceId, ServiceId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeregisterInstance", Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId); aws_config=aws_config)
deregister_instance(InstanceId, ServiceId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DeregisterInstance", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId), params)); aws_config=aws_config)

"""
    discover_instances(namespace_name, service_name)
    discover_instances(namespace_name, service_name, params::Dict{String,<:Any})

Discovers registered instances for a specified namespace and service. You can use
DiscoverInstances to discover instances for any type of namespace. For public and private
DNS namespaces, you can also use DNS queries to discover instances.

# Arguments
- `namespace_name`: The HttpName name of the namespace, found in the HttpProperties member
  of the Properties member of the namespace.
- `service_name`: The name of the service that you specified when you registered the
  instance.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"HealthStatus"`: The health status of the instances that you want to discover.
- `"MaxResults"`: The maximum number of instances that you want AWS Cloud Map to return in
  the response to a DiscoverInstances request. If you don't specify a value for MaxResults,
  AWS Cloud Map returns up to 100 instances.
- `"OptionalParameters"`: Opportunistic filters to scope the results based on custom
  attributes. If there are instances that match both the filters specified in both the
  QueryParameters parameter and this parameter, they are returned. Otherwise, these filters
  are ignored and only instances that match the filters specified in the QueryParameters
  parameter are returned.
- `"QueryParameters"`: Filters to scope the results based on custom attributes for the
  instance. For example, {version=v1, az=1a}. Only instances that match all the specified
  key-value pairs are returned.
"""
discover_instances(NamespaceName, ServiceName; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DiscoverInstances", Dict{String, Any}("NamespaceName"=>NamespaceName, "ServiceName"=>ServiceName); aws_config=aws_config)
discover_instances(NamespaceName, ServiceName, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("DiscoverInstances", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("NamespaceName"=>NamespaceName, "ServiceName"=>ServiceName), params)); aws_config=aws_config)

"""
    get_instance(instance_id, service_id)
    get_instance(instance_id, service_id, params::Dict{String,<:Any})

Gets information about a specified instance.

# Arguments
- `instance_id`: The ID of the instance that you want to get information about.
- `service_id`: The ID of the service that the instance is associated with.

"""
get_instance(InstanceId, ServiceId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetInstance", Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId); aws_config=aws_config)
get_instance(InstanceId, ServiceId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetInstance", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId), params)); aws_config=aws_config)

"""
    get_instances_health_status(service_id)
    get_instances_health_status(service_id, params::Dict{String,<:Any})

Gets the current health status (Healthy, Unhealthy, or Unknown) of one or more instances
that are associated with a specified service.  There is a brief delay between when you
register an instance and when the health status for the instance is available.

# Arguments
- `service_id`: The ID of the service that the instance is associated with.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"Instances"`: An array that contains the IDs of all the instances that you want to get
  the health status for. If you omit Instances, AWS Cloud Map returns the health status for
  all the instances that are associated with the specified service.  To get the IDs for the
  instances that you've registered by using a specified service, submit a ListInstances
  request.
- `"MaxResults"`: The maximum number of instances that you want AWS Cloud Map to return in
  the response to a GetInstancesHealthStatus request. If you don't specify a value for
  MaxResults, AWS Cloud Map returns up to 100 instances.
- `"NextToken"`: For the first GetInstancesHealthStatus request, omit this value. If more
  than MaxResults instances match the specified criteria, you can submit another
  GetInstancesHealthStatus request to get the next group of results. Specify the value of
  NextToken from the previous response in the next request.
"""
get_instances_health_status(ServiceId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetInstancesHealthStatus", Dict{String, Any}("ServiceId"=>ServiceId); aws_config=aws_config)
get_instances_health_status(ServiceId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetInstancesHealthStatus", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("ServiceId"=>ServiceId), params)); aws_config=aws_config)

"""
    get_namespace(id)
    get_namespace(id, params::Dict{String,<:Any})

Gets information about a namespace.

# Arguments
- `id`: The ID of the namespace that you want to get information about.

"""
get_namespace(Id; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetNamespace", Dict{String, Any}("Id"=>Id); aws_config=aws_config)
get_namespace(Id, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetNamespace", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Id"=>Id), params)); aws_config=aws_config)

"""
    get_operation(operation_id)
    get_operation(operation_id, params::Dict{String,<:Any})

Gets information about any operation that returns an operation ID in the response, such as
a CreateService request.  To get a list of operations that match specified criteria, see
ListOperations.

# Arguments
- `operation_id`: The ID of the operation that you want to get more information about.

"""
get_operation(OperationId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetOperation", Dict{String, Any}("OperationId"=>OperationId); aws_config=aws_config)
get_operation(OperationId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetOperation", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("OperationId"=>OperationId), params)); aws_config=aws_config)

"""
    get_service(id)
    get_service(id, params::Dict{String,<:Any})

Gets the settings for a specified service.

# Arguments
- `id`: The ID of the service that you want to get settings for.

"""
get_service(Id; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetService", Dict{String, Any}("Id"=>Id); aws_config=aws_config)
get_service(Id, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("GetService", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Id"=>Id), params)); aws_config=aws_config)

"""
    list_instances(service_id)
    list_instances(service_id, params::Dict{String,<:Any})

Lists summary information about the instances that you registered by using a specified
service.

# Arguments
- `service_id`: The ID of the service that you want to list instances for.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"MaxResults"`: The maximum number of instances that you want AWS Cloud Map to return in
  the response to a ListInstances request. If you don't specify a value for MaxResults, AWS
  Cloud Map returns up to 100 instances.
- `"NextToken"`: For the first ListInstances request, omit this value. If more than
  MaxResults instances match the specified criteria, you can submit another ListInstances
  request to get the next group of results. Specify the value of NextToken from the previous
  response in the next request.
"""
list_instances(ServiceId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListInstances", Dict{String, Any}("ServiceId"=>ServiceId); aws_config=aws_config)
list_instances(ServiceId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListInstances", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("ServiceId"=>ServiceId), params)); aws_config=aws_config)

"""
    list_namespaces()
    list_namespaces(params::Dict{String,<:Any})

Lists summary information about the namespaces that were created by the current AWS account.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"Filters"`: A complex type that contains specifications for the namespaces that you want
  to list. If you specify more than one filter, a namespace must match all filters to be
  returned by ListNamespaces.
- `"MaxResults"`: The maximum number of namespaces that you want AWS Cloud Map to return in
  the response to a ListNamespaces request. If you don't specify a value for MaxResults, AWS
  Cloud Map returns up to 100 namespaces.
- `"NextToken"`: For the first ListNamespaces request, omit this value. If the response
  contains NextToken, submit another ListNamespaces request to get the next group of results.
  Specify the value of NextToken from the previous response in the next request.  AWS Cloud
  Map gets MaxResults namespaces and then filters them based on the specified criteria. It's
  possible that no namespaces in the first MaxResults namespaces matched the specified
  criteria but that subsequent groups of MaxResults namespaces do contain namespaces that
  match the criteria.
"""
list_namespaces(; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListNamespaces"; aws_config=aws_config)
list_namespaces(params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListNamespaces", params; aws_config=aws_config)

"""
    list_operations()
    list_operations(params::Dict{String,<:Any})

Lists operations that match the criteria that you specify.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"Filters"`: A complex type that contains specifications for the operations that you want
  to list, for example, operations that you started between a specified start date and end
  date. If you specify more than one filter, an operation must match all filters to be
  returned by ListOperations.
- `"MaxResults"`: The maximum number of items that you want AWS Cloud Map to return in the
  response to a ListOperations request. If you don't specify a value for MaxResults, AWS
  Cloud Map returns up to 100 operations.
- `"NextToken"`: For the first ListOperations request, omit this value. If the response
  contains NextToken, submit another ListOperations request to get the next group of results.
  Specify the value of NextToken from the previous response in the next request.  AWS Cloud
  Map gets MaxResults operations and then filters them based on the specified criteria. It's
  possible that no operations in the first MaxResults operations matched the specified
  criteria but that subsequent groups of MaxResults operations do contain operations that
  match the criteria.
"""
list_operations(; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListOperations"; aws_config=aws_config)
list_operations(params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListOperations", params; aws_config=aws_config)

"""
    list_services()
    list_services(params::Dict{String,<:Any})

Lists summary information for all the services that are associated with one or more
specified namespaces.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"Filters"`: A complex type that contains specifications for the namespaces that you want
  to list services for.  If you specify more than one filter, an operation must match all
  filters to be returned by ListServices.
- `"MaxResults"`: The maximum number of services that you want AWS Cloud Map to return in
  the response to a ListServices request. If you don't specify a value for MaxResults, AWS
  Cloud Map returns up to 100 services.
- `"NextToken"`: For the first ListServices request, omit this value. If the response
  contains NextToken, submit another ListServices request to get the next group of results.
  Specify the value of NextToken from the previous response in the next request.  AWS Cloud
  Map gets MaxResults services and then filters them based on the specified criteria. It's
  possible that no services in the first MaxResults services matched the specified criteria
  but that subsequent groups of MaxResults services do contain services that match the
  criteria.
"""
list_services(; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListServices"; aws_config=aws_config)
list_services(params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListServices", params; aws_config=aws_config)

"""
    list_tags_for_resource(resource_arn)
    list_tags_for_resource(resource_arn, params::Dict{String,<:Any})

Lists tags for the specified resource.

# Arguments
- `resource_arn`: The Amazon Resource Name (ARN) of the resource that you want to retrieve
  tags for.

"""
list_tags_for_resource(ResourceARN; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListTagsForResource", Dict{String, Any}("ResourceARN"=>ResourceARN); aws_config=aws_config)
list_tags_for_resource(ResourceARN, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("ListTagsForResource", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("ResourceARN"=>ResourceARN), params)); aws_config=aws_config)

"""
    register_instance(attributes, instance_id, service_id)
    register_instance(attributes, instance_id, service_id, params::Dict{String,<:Any})

Creates or updates one or more records and, optionally, creates a health check based on the
settings in a specified service. When you submit a RegisterInstance request, the following
occurs:   For each DNS record that you define in the service that is specified by
ServiceId, a record is created or updated in the hosted zone that is associated with the
corresponding namespace.   If the service includes HealthCheckConfig, a health check is
created based on the settings in the health check configuration.   The health check, if
any, is associated with each of the new or updated records.    One RegisterInstance request
must complete before you can submit another request and specify the same service ID and
instance ID.  For more information, see CreateService. When AWS Cloud Map receives a DNS
query for the specified DNS name, it returns the applicable value:    If the health check
is healthy: returns all the records    If the health check is unhealthy: returns the
applicable value for the last healthy instance    If you didn't specify a health check
configuration: returns all the records   For the current quota on the number of instances
that you can register using the same namespace and using the same service, see AWS Cloud
Map Limits in the AWS Cloud Map Developer Guide.

# Arguments
- `attributes`: A string map that contains the following information for the service that
  you specify in ServiceId:   The attributes that apply to the records that are defined in
  the service.    For each attribute, the applicable value.   Supported attribute keys
  include the following:  AWS_ALIAS_DNS_NAME  If you want AWS Cloud Map to create an Amazon
  Route 53 alias record that routes traffic to an Elastic Load Balancing load balancer,
  specify the DNS name that is associated with the load balancer. For information about how
  to get the DNS name, see \"DNSName\" in the topic AliasTarget in the Route 53 API
  Reference. Note the following:   The configuration for the service that is specified by
  ServiceId must include settings for an A record, an AAAA record, or both.   In the service
  that is specified by ServiceId, the value of RoutingPolicy must be WEIGHTED.   If the
  service that is specified by ServiceId includes HealthCheckConfig settings, AWS Cloud Map
  will create the Route 53 health check, but it doesn't associate the health check with the
  alias record.   Auto naming currently doesn't support creating alias records that route
  traffic to AWS resources other than Elastic Load Balancing load balancers.   If you specify
  a value for AWS_ALIAS_DNS_NAME, don't specify values for any of the AWS_INSTANCE
  attributes.    AWS_EC2_INSTANCE_ID   HTTP namespaces only. The Amazon EC2 instance ID for
  the instance. If the AWS_EC2_INSTANCE_ID attribute is specified, then the only other
  attribute that can be specified is AWS_INIT_HEALTH_STATUS. When the AWS_EC2_INSTANCE_ID
  attribute is specified, then the AWS_INSTANCE_IPV4 attribute will be filled out with the
  primary private IPv4 address.  AWS_INIT_HEALTH_STATUS  If the service configuration
  includes HealthCheckCustomConfig, you can optionally use AWS_INIT_HEALTH_STATUS to specify
  the initial status of the custom health check, HEALTHY or UNHEALTHY. If you don't specify a
  value for AWS_INIT_HEALTH_STATUS, the initial status is HEALTHY.  AWS_INSTANCE_CNAME  If
  the service configuration includes a CNAME record, the domain name that you want Route 53
  to return in response to DNS queries, for example, example.com. This value is required if
  the service specified by ServiceId includes settings for an CNAME record.
  AWS_INSTANCE_IPV4  If the service configuration includes an A record, the IPv4 address that
  you want Route 53 to return in response to DNS queries, for example, 192.0.2.44. This
  value is required if the service specified by ServiceId includes settings for an A record.
  If the service includes settings for an SRV record, you must specify a value for
  AWS_INSTANCE_IPV4, AWS_INSTANCE_IPV6, or both.  AWS_INSTANCE_IPV6  If the service
  configuration includes an AAAA record, the IPv6 address that you want Route 53 to return
  in response to DNS queries, for example, 2001:0db8:85a3:0000:0000:abcd:0001:2345. This
  value is required if the service specified by ServiceId includes settings for an AAAA
  record. If the service includes settings for an SRV record, you must specify a value for
  AWS_INSTANCE_IPV4, AWS_INSTANCE_IPV6, or both.  AWS_INSTANCE_PORT  If the service includes
  an SRV record, the value that you want Route 53 to return for the port. If the service
  includes HealthCheckConfig, the port on the endpoint that you want Route 53 to send
  requests to.  This value is required if you specified settings for an SRV record or a
  Route 53 health check when you created the service.  Custom attributes  You can add up to
  30 custom attributes. For each key-value pair, the maximum length of the attribute name is
  255 characters, and the maximum length of the attribute value is 1,024 characters. The
  total size of all provided attributes (sum of all keys and values) must not exceed 5,000
  characters.
- `instance_id`: An identifier that you want to associate with the instance. Note the
  following:   If the service that is specified by ServiceId includes settings for an SRV
  record, the value of InstanceId is automatically included as part of the value for the SRV
  record. For more information, see DnsRecord &gt; Type.   You can use this value to update
  an existing instance.   To register a new instance, you must specify a value that is unique
  among instances that you register by using the same service.    If you specify an existing
  InstanceId and ServiceId, AWS Cloud Map updates the existing DNS records, if any. If
  there's also an existing health check, AWS Cloud Map deletes the old health check and
  creates a new one.   The health check isn't deleted immediately, so it will still appear
  for a while if you submit a ListHealthChecks request, for example.
- `service_id`: The ID of the service that you want to use for settings for the instance.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"CreatorRequestId"`: A unique string that identifies the request and that allows failed
  RegisterInstance requests to be retried without the risk of executing the operation twice.
  You must use a unique CreatorRequestId string every time you submit a RegisterInstance
  request if you're registering additional instances for the same namespace and service.
  CreatorRequestId can be any unique string, for example, a date/time stamp.
"""
register_instance(Attributes, InstanceId, ServiceId; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("RegisterInstance", Dict{String, Any}("Attributes"=>Attributes, "InstanceId"=>InstanceId, "ServiceId"=>ServiceId, "CreatorRequestId"=>string(uuid4())); aws_config=aws_config)
register_instance(Attributes, InstanceId, ServiceId, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("RegisterInstance", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Attributes"=>Attributes, "InstanceId"=>InstanceId, "ServiceId"=>ServiceId, "CreatorRequestId"=>string(uuid4())), params)); aws_config=aws_config)

"""
    tag_resource(resource_arn, tags)
    tag_resource(resource_arn, tags, params::Dict{String,<:Any})

Adds one or more tags to the specified resource.

# Arguments
- `resource_arn`: The Amazon Resource Name (ARN) of the resource that you want to retrieve
  tags for.
- `tags`: The tags to add to the specified resource. Specifying the tag key is required.
  You can set the value of a tag to an empty string, but you can't set the value of a tag to
  null.

"""
tag_resource(ResourceARN, Tags; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("TagResource", Dict{String, Any}("ResourceARN"=>ResourceARN, "Tags"=>Tags); aws_config=aws_config)
tag_resource(ResourceARN, Tags, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("TagResource", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("ResourceARN"=>ResourceARN, "Tags"=>Tags), params)); aws_config=aws_config)

"""
    untag_resource(resource_arn, tag_keys)
    untag_resource(resource_arn, tag_keys, params::Dict{String,<:Any})

Removes one or more tags from the specified resource.

# Arguments
- `resource_arn`: The Amazon Resource Name (ARN) of the resource that you want to retrieve
  tags for.
- `tag_keys`: The tag keys to remove from the specified resource.

"""
untag_resource(ResourceARN, TagKeys; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UntagResource", Dict{String, Any}("ResourceARN"=>ResourceARN, "TagKeys"=>TagKeys); aws_config=aws_config)
untag_resource(ResourceARN, TagKeys, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UntagResource", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("ResourceARN"=>ResourceARN, "TagKeys"=>TagKeys), params)); aws_config=aws_config)

"""
    update_instance_custom_health_status(instance_id, service_id, status)
    update_instance_custom_health_status(instance_id, service_id, status, params::Dict{String,<:Any})

Submits a request to change the health status of a custom health check to healthy or
unhealthy. You can use UpdateInstanceCustomHealthStatus to change the status only for
custom health checks, which you define using HealthCheckCustomConfig when you create a
service. You can't use it to change the status for Route 53 health checks, which you
define using HealthCheckConfig. For more information, see HealthCheckCustomConfig.

# Arguments
- `instance_id`: The ID of the instance that you want to change the health status for.
- `service_id`: The ID of the service that includes the configuration for the custom health
  check that you want to change the status for.
- `status`: The new status of the instance, HEALTHY or UNHEALTHY.

"""
update_instance_custom_health_status(InstanceId, ServiceId, Status; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UpdateInstanceCustomHealthStatus", Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId, "Status"=>Status); aws_config=aws_config)
update_instance_custom_health_status(InstanceId, ServiceId, Status, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UpdateInstanceCustomHealthStatus", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("InstanceId"=>InstanceId, "ServiceId"=>ServiceId, "Status"=>Status), params)); aws_config=aws_config)

"""
    update_service(id, service)
    update_service(id, service, params::Dict{String,<:Any})

Submits a request to perform the following operations:   Update the TTL setting for
existing DnsRecords configurations   Add, update, or delete HealthCheckConfig for a
specified service  You can't add, update, or delete a HealthCheckCustomConfig
configuration.    For public and private DNS namespaces, note the following:   If you omit
any existing DnsRecords or HealthCheckConfig configurations from an UpdateService request,
the configurations are deleted from the service.   If you omit an existing
HealthCheckCustomConfig configuration from an UpdateService request, the configuration
isn't deleted from the service.   When you update settings for a service, AWS Cloud Map
also updates the corresponding settings in all the records and health checks that were
created by using the specified service.

# Arguments
- `id`: The ID of the service that you want to update.
- `service`: A complex type that contains the new settings for the service.

"""
update_service(Id, Service; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UpdateService", Dict{String, Any}("Id"=>Id, "Service"=>Service); aws_config=aws_config)
update_service(Id, Service, params::AbstractDict{String}; aws_config::AbstractAWSConfig=global_aws_config()) = servicediscovery("UpdateService", Dict{String, Any}(mergewith(_merge, Dict{String, Any}("Id"=>Id, "Service"=>Service), params)); aws_config=aws_config)
