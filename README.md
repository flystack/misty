# Introduction
Misty is a HTTP client for OpenStack APIs, aiming to be fast, flexible and exhaustive.
Misty acts as a conduit to OpenStack APIs by handling requests as transparently as possible.

## Features
* Flexible Openstack APIs integration
* Standardized Openstack APIs: [Based upon API-ref](https://developer.openstack.org/api-guide/quick-start/)
* Automatically generated API schemas - Any request can be overridden
* Versions and Microversions
* Transparent Request data hanlding
* Response data format of choice: JSON or raw (Ruby)
* Custom HTTP Methods for special needs
* On demand services - Auto loads required versions
* Low dependency - Use standard Net/HTTP and JSON gem only
* Persistent HTTP connections (default since HTTP 1.1 anyway)

## A solid KISS
For REST transactions Misty relies on standard Net/HTTP library.  
No other gems are required besides 'json'.  

Not having to use the help of a more complex HTTP framework is a choice that reduces dependencies.  
Meanwhile a better reason would be because Openstack offers a common modus operandi across all APIs.  
The authentication process provides a Service Catalog serving all available APIs entry points.

## APIs Definitions
The rich variety of OpenStack projects requires lots of Application Program Interfaces to handle.  
Maintaining and extending those APIs implies a structural complexity challenge.  
Therefore the more automated the process, the better.  
Thanks to the help of Phoenix project [OpenStack API-ref](https://developer.openstack.org/api-guide/quick-start/)
providing the latest standard of OpenStack APIs.  
The APIs interface definitions are generated automatically from the API-ref reference manuals (misty-builder) which
allows:
* More consistent APIs
* More recent APIs definitions
* Easier addition of a new service's API

[1] https://developer.openstack.org/api-guide/quick-start/

# Install & Use

## Fetch and install
``` ruby
gem install misty
```

## Quick start
```ruby
require 'misty'

auth_v3 = {
  :url      => 'http://localhost:5000',
  :user               => 'admin',
  :password           => 'secret',
  :domain             => 'default',
  :project            => 'admin',
  :project_domain_id  => 'default'
}

openstack = Misty::Cloud.new(:auth => auth_v3)

puts openstack.compute.list_servers.body
puts openstack.compute.list_flavors.body
networks = openstack.network.list_networks
network_id = networks.body['networks'][0]['id']
network = openstack.network.show_network_details(network_id)
puts network.body
```

## Services
Once a Misty::Cloud object is created, the Openstack services can be used.

The Cloud object is authenticated by the identity server (bootstrap) and is provided with a service catalog.
When an OpenStack API service is required, the catalog entry's endpoint is used and the service is dynamically called.

Each service name (i.e. `compute`) is the object handling API requests.

 ```ruby
openstack = Misty::Cloud.new(:auth => { ... })
openstack.compute.list_servers
openstack.network.list_networks
data = Misty.to_json('network': {'name': 'my-network'})
openstack.network.create_network(data)
```

To obtain the list of supported services:
```ruby
> require 'misty'
> puts Misty.services
application_catalog: murano, versions: ["v1"]
alarming: aodh, versions: ["v2"]
backup: freezer, versions: ["v1"]
baremetal: ironic, microversion: v1
block_storage: cinder, versions: ["v2", "v1"], microversion: v3
clustering: senlin, versions: ["v1"]
compute: nova, microversion: v2.1
container_infrastructure_management: magnum, microversion: v1
data_processing: sahara, versions: ["v1.1"]
data_protection_orchestration: karbor, versions: ["v1"]
database: trove, versions: ["v1.0"]
domain_name_server: designate, versions: ["v2"]
identity: keystone, versions: ["v3", "v2.0"]
image: glance, versions: ["v2", "v1"]
load_balancer: octavia, versions: ["v2.0"]
messaging: zaqar, versions: ["v2"]
metering: ceilometer, versions: ["v2"]
networking: neutron, versions: ["v2.0"]
nfv_orchestration: tacker, versions: ["v1.0"]
object_storage: swift, versions: ["v1"]
orchestration: heat, versions: ["v1"]
search: searchlight, versions: ["v1"]
shared_file_systems: manila, microversion: v2
```

### Headers
HTTP headers can be defined at 3 different levels:
* Global headers are applied across all services, see `:headers` in "Global parameters" section.
* Service level headers are applied on every request of an involved service, see "Services options" section.
* Request level header are passed on per request basis.

The Headers are cumulative, therefore a request level header will be added on top of the global and Service levels
headers.

### Prefixes
A shorter name can be used to call a service only if it's unique among all services.
For instance `net` or `network` can be used instead of `networking`.
Meanwhile `data` doesn't work because it's ambiguous between `data_processing` and `data_protection_orchestration`

### Aliases  
* `dns` is an alias for `domain_name_server`  
* `volume` is an alias for `block_storage`  

## Openstack service name
Different service names can be used for a specific Openstack Service by using the :service_names option (see below).

## Requests
The #requests method provides the available requests for a service, for example:
```ruby
openstack.compute.requests

=> [:add_a_single_tag,
 :add_associate_fixed_ip_addfixedip_action_deprecated,
 :add_associate_floating_ip_addfloatingip_action_deprecated,
 :add_flavor_access_to_tenant_addtenantaccess_action,
 :add_host,
 :add_network,
 :add_security_group_to_a_server_addsecuritygroup_action,
 :associate_host_deprecated,
 :attach_a_volume_to_an_instance,
 :bulk_delete_floating_ips,
 :capacities,
 :change_administrative_password_changepassword_action,
 :check_tag_existence,
 :clear_admin_password,
 :confirm_resized_server_confirmresize_action,
 :create_agent_build,
 :create_aggregate,
 :create_allocate_floating_ip_address,
 :create_assisted_volume_snapshots,
 :create_cell,
 :create_cloudpipe,
 :create_console,
.../...
```

## Setup

### Authentication information parameter
The URL and credentials details are necessary to authenticate with the identity server (Keystone).

The credentials are a combination of "id" and "name" used to uniquely identify projects, users and their domains.
When using only the name, a domain must be specified to guarantee a unique record from the Identity service.

The following parameters can be used:  
* `:domain_id`  
  Domain id used for authentication scope  
  Default: `"default"`  
* `:domain`  
  Domain name used for authentication scope  
  Default: `"Default"`  
* `:project_id`  
  Project id  
* `:project`  
  Project name  
* `:project_domain_id`  
  Project domain id
* `:project_domain`  
  Project domain name  
* `:tenant_id`  
  Tenant id, used only for Keystone v2.0  
* `:tenant`  
  Tenant name, used only for Keystone v2.0  
* `:user_id`  
  User id  
* `:user`  
  User name  
* `:user_domain_id`  
  User domain id
* `:user_domain`  
  User domain name  
* `:password`  
  Password for user. Cannot be used together with `:token`.
* `:token`  
  User provided token, overrides all user and password parameters.
* `:context`  
  Bypass the authentication by providing a proper context with `token id`, `service catalog` and `expire date`.
  Overrides all user and password parameters  
  Example: ``{:context => { :token => token_id, :catalog => service_catalog, :expires => expire_date }}``

#### Keystone v3
Keystone v3 is default recommended version:

```ruby
auth = {
  :url            => 'http://localhost:5000',
  :user           => 'admin',
  :user_domain    => 'default',
  :password       => 'secret',
  :project        => 'admin',
  :project_domain => 'default'
  }
}
```

Alternatively, using IDs:

```ruby
auth = {
  :url         => 'http://localhost:5000',
  :user_id    => '48985e6b8da145699d411f12a3459fca',
  :password   => 'secret',
  :project_id => '8e1e232f6cbb4116bbef715d8a0afe6e',
  }
}
```
#### Keystone v2.0
Provide the tenant details, Misty will detect it's using v2.0 for authentication:

```ruby
auth = {
  :url      => 'http://localhost:5000',
  :user     => 'admin',
  :password => 'secret',
  :tenant   => 'admin',
}
```
### Logging parameters
* :log_file  
  Log destination.  
  Value is either file path (./misty.log) or IO object (SDOUT)
  Default is no output (`/dev/null`).  
* :log_level  
  Value is Fixnum - Default is 1 (Logger::INFO) - See Logger from Ruby standard Library

```ruby
openstack = Misty::Cloud.new(:auth => auth, :content_type => :ruby, :log_file => STDOUT)
```

#### Global parameters
The following options are applied to each service unless specifically provided for a service.

* :content_type  
  Format of the body of the successful HTTP responses to be JSON or Ruby structures.  
  Type: Symbol  
  Allowed values: `:json`, `:ruby`  
  Default: `:ruby`
* :headers  
  HTTP Headers to be applied to all services
  Type: Hash  
  Default: {}
* :region_id  
  Type: String  
  Default: "regionOne"  
* :interface  
  Type: String  
  Allowed values: "public", "internal", "admin"  
  Default: "public"  
* :ssl_verify_mode  
  When using SSL mode (defined by URI scheme => "https://")  
  Type: Boolean  
  Default: `true`  

### Services Options
Each service can have specific parameters.

```ruby
openstack = Misty::Cloud.new(:auth => auth, :identity => {}, :compute => {})
```

The following options are available:
* :api_version  
  Type: String  
  Default: The latest supported version - See Misty.services for other versions.  
* :base_path  
  Allows to force the base path for every URL requests.  
  Type: String  
* :base_url  
  Allows to force the base URL for every requests.  
  Type: String        
* :headers
  Optional headers
  Type: Hash
* :interface  
  Allows to provide an alternate interface. Allowed values are "public", "internal" or "admin"  
  Type: String  
  Default: Determined from global value  
* :region_id  
  Type: String  
  Default: Determined from global value  
* :service_names  
  Allows to use a difference name for the service. For instance "identity3" for the identity service.  
  Type: String  
  Default: Determined from Misty.services  
* :ssl_verify_mode  
  Type: Boolean  
  Default: Determined from global value  
* :version  
  Version to be used when microversion is supported by the service.  
  Type: String  
  Allowed values: "CURRENT", "LATEST", "SUPPORTED", or a version number such as "2.0" or "3"  
  Default: `"CURRENT"`  

Example:
```ruby
openstack = Misty::Cloud.new(:auth => auth, :log_level => 0, :identity => {:region_id => 'regionTwo'}, :compute => {:version => '2.27', :interface => 'admin'})
```

### Services Headers
HTTP headers can be optionally added to any request.
A Header object must be created and passed as the last parameter of a request.

For example for an already initialized cloud:
```ruby
header = Misty::HTTP::Header.new(
  'x-container-meta-web-listings' => false,
  'x-container-meta-quota-count'  => "",
  'x-container-meta-quota-bytes'  => nil,
  'x-versions-location'           => "",
  'x-container-meta-web-index'    => ""
)

openstack.object_storage.create_update_or_delete_container_metadata(container_name, header)
```

## Direct REST HTTP Methods
To send requests directly use the 'get', 'delete', 'post' and 'put' methods directly:
```ruby
openstack.network.post('/v2.0/qos/policies/48985e6b8da145699d411f12a3459fca/dscp_marking_rules', data)
```
# Requirements

## Ruby versions tested
* Ruby MRI 2.4.2
* Ruby MRI 2.4.1
* Ruby MRI 2.4.0
* Ruby MRI 2.3.4
* Ruby MRI 2.3.3
* Ruby MRI 2.3.2
* Ruby MRI 2.3.1
* Ruby MRI 2.3.0

# Contributing
Contributors are welcome and must adhere to the [Contributor covenant code of conduct](http://contributor-covenant.org/).

Please submit issues/bugs and patches on the [Misty repository](https://github.com/flystack/misty).

# Copyright
Apache License Version 2.0, January 2004 http://www.apache.org/licenses/ - See [LICENSE](LICENSE.md) for details.
