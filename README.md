# Introduction
Misty is a HTTP client for OpenStack APIs, aiming to be fast and to provide a flexible and at same time exhaustive
APIs experience.

## Features
* Exhaustive and latest Openstack APIs
* Multiple Service versions
* Microversions
* Based upon Net/HTTP
* Minimalistic gem dependencies - Only json is required
* Dynamic services by autoloading only required service's version
* Token automatically refreshed when expired
* Raw JSON or Ruby format for queries and responses
* Persistent HTTP connections (default since HTTP 1.1 anyway) but for the authentication bootstrapping
* Direct HTTP Methods for custom needs

## A solid KISS
For REST transactions, Misty uses only Net/HTTP from the Ruby Standard Library.  So besides 'json', no other gem are
required.  
Because OpenStack authentication and Service Catalog management are very specific and shared by all the APIs, once taken
care of, there is no need for a complex HTTP framework.  
This offers a solid foundation with reduced dependencies.

## APIs Definitions
The rich variety of OpenStack projects requires lots of Application Program Interfaces to handle.  
Maintaining and extending those APIs is a structural complexity challenge.  
Therefore the more automated the process, the better.  
Thanks to the help of Phoenix project, the OpenStack API-ref [1] provides standardization of the OpenStack APIs.  
The APIs can be processed almost automatically from the API-ref reference manuals (misty-builder).  
This allows:
* More consistent APIs using automated control
* More recent APIs definitions
* Easier to add APIs

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
  :user     => "admin",
  :password => "secret",
  :project  => "admin",
  :domain   => "default"
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

The Cloud object authenticates against the identity server (bootstrap process) and obtains the service catalog.
When an OpenStack API service is used, its endpoint is determined from the catalog and the service is dynamically called
by Misty so only the services used are loaded.

The service generic name, such as `compute`, is used to submit requests with an OpenStack service API.

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
alarming | aodh | ["v2"]
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
messaging | zaqar | ["v2"]
metering | ceilometer | ["v2"]
network | neutron | ["v2.0"]
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
  Previous Keystone v3 token for user. Can only be used with Keystone v3. Overrides all user and password parameters.

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
* :http_proxy  
  For example: `"http://userid:password@somewhere.com:8080/"` or `ENV["http_proxy"]`  
  Type: String  
  Default: `""`  
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
