# Introduction
Misty is a HTTP client for OpenStack APIs, aiming to be fast and to provide a flexible and at same time exhaustive
APIs experience.

## Features
* Flexible Openstack APIs integration
* Standardized Openstack APIs: [Based upon API-ref](https://developer.openstack.org/api-guide/quick-start/)
* Multiple Service versions and Microversions
* On demand services - Auto loads required versions
* Low  dependency - Use standard Net/HTTP and JSON gem only
* I/O format choice: JSON or Ruby structures for queries and responses
* Persistent HTTP connections (default since HTTP 1.1 anyway) but for the authentication bootstrapping
* Direct HTTP Methods for custom needs

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
  :url      => "http://localhost:5000",
  :user               => "admin",
  :password           => "secret",
  :domain             => "default",
  :project            => "admin",
  :project_domain_id  => 'default'
}

openstack = Misty::Cloud.new(:auth => auth_v3)

puts openstack.compute.list_servers.body
puts openstack.compute.list_flavors.body
networks = openstack.network.list_networks
network_id = networks.body["networks"][0]['id']
network = openstack.network.show_network_details(network_id)
puts network.body
```

## Services
Once the Misty::Cloud object is created, the Openstack services can be used.

The Cloud object is authenticated by the identity server (bootstrap) and is provided with a service catalog.
When an OpenStack API service is required, the catalog entry's endpoint is used and the service is dynamically called.

Each service name (i.e. `compute`) is the object handling API requests.

 ```ruby
openstack = Misty::Cloud.new(:auth => { ... })
openstack.compute.list_servers
openstack.network.list_networks
openstack.network.create_network("network": {"name": "my-network"})
```

To obtain the list of supported services:
```ruby
require 'misty'
puts Misty.services
```

Which produces the equivalent of the following:  

name | project | versions
--- | --- | ---
application_catalog | murano | ["v1"]
alarming | aodh | ["v2"]
backup | freezer | ["v1"]
baremetal | ironic | ["v1"]
block_storage | cinder | ["v3", "v1"]
clustering | senlin | ["v1"]
compute | nova | ["v2.1"]
container | magnum | ["v1"]
data_processing | sahara | ["v1.1"]
data_protection | karbor | ["v1"]
database | trove | ["v1.0"]
dns | designate | ["v2"]
identity | keystone | ["v3", "v2.0"]
image | glance | ["v2", "v1"]
load_balancer | octavia | ["v2.0"]
messaging | zaqar | ["v2"]
metering | ceilometer | ["v2"]
networking | neutron | ["v2.0"]
nfv_orchestration | tacker | ["v1.0"]
object_storage | swift | ["v1"]
orchestration | heat | ["v1"]
search | searchlight | ["v1"]
shared_file_systems | manila | ["v2"]

* Notes  
  When an Openstack service requires a different service name, the :service_names option can be used (see below).

The #requests method provides the available requests for a service, for example:
```ruby
openstack.compute.requests
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
  I you have a proper context with `token id`, `service catalog` and `expire date` you can bypass the authentication  
  Overrides all user and password parameters  
  Example: ``{:context => { :token => token_id, :catalog => service_catalog, :expires => expire_date }}``

#### Keystone v3
Keystone v3 is default recommended version:

```ruby
auth = {
  :url            => "http://localhost:5000",
  :user           => "admin",
  :user_domain    => "default",
  :password       => "secret",
  :project        => "admin",
  :project_domain => "default"
  }
}
```

Alternatively, using IDs:

```ruby
auth = {
  :url         => "http://localhost:5000",
  :user_id    => "48985e6b8da145699d411f12a3459fca",
  :password   => "secret",
  :project_id => "8e1e232f6cbb4116bbef715d8a0afe6e",
  }
}
```
#### Keystone v2.0
Provide the tenant details, Misty will detect it's using v2.0 for authentication:

```ruby
auth = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :tenant   => "admin",
}
```
### Logging parameters
* :log_file  
  File name and path for log file.  
  Value is file path or IO object - Default is `./misty.log`.  
  For example: use STDOUT for terminal output or alternatively use '/dev/null' to avoid the logs entirely.
* :log_level  
  Value is Fixnum - Default is 1 (Logger::INFO) - See Logger from Ruby standard Library

```ruby
openstack = Misty::Cloud.new(:auth => auth, :content_type => :ruby, :log_file => STDOUT)
```

#### Global parameters
The following options are applied to each service unless specifically provided for a service.

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
* :content_type  
  Format of the body of the successful HTTP responses to be JSON or Ruby structures.  
  Type: Symbol  
  Allowed values: `:json`, `:ruby`  
  Default: `:ruby`

### Services Options
Each service can get parameters to be specified.

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
openstack = Misty::Cloud.new(:auth => auth, :log_level => 0, :identity => {:region_id => "regionTwo"}, :compute => {:version => "2.27", :interface => "admin"})
```

## Direct REST HTTP Methods
To send requests directly use the 'get', 'delete', 'post' and 'put' methods directly:
```ruby
openstack.network.post("/v2.0/qos/policies/48985e6b8da145699d411f12a3459fca/dscp_marking_rules", data)
```
# Requirements

## Ruby versions tested
* Ruby 2.4.1
* Ruby 2.4.0
* Ruby 2.3.4
* Ruby 2.3.3
* Ruby 2.3.2
* Ruby 2.3.1
* Ruby 2.3.0

# Contributing
Contributors are welcome and must adhere to the [Contributor covenant code of conduct](http://contributor-covenant.org/).

Please submit issues/bugs and patches on the [Misty repository](https://github.com/flystack/misty).

# Copyright
Apache License Version 2.0, January 2004 http://www.apache.org/licenses/ - See [LICENSE](LICENSE.md) for details.
