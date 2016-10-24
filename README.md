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

### Authentication
The URL and credentials details are necessary to authenticate with the identity server (Keystone).

To provide a Keystone V3, which is the default recommended version:
```ruby
auth = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :project  => "admin",
  :domain   => "default"
  }
}
```
Alternatively, for Keystone V2, just provide the tenant details, Misty will detect it's using Keystone V2:
```ruby
auth = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :tenant   => "admin",
}
```

### Global options
Besides the authentication details, the following options which apply for the whole cloud

* :content_type  
  Format of the body of the successful HTTP responses to be JSON or Ruby structures.  
  Value is symbol. Allowed value is `:json`.  
  By default response body are converted to Ruby structures.
* :log_file  
  File name and path for log file.  
  Value is file path or IO object - Default is `./misty.log`.  
  For example: use STDOUT for terminal output or alternatively use '/dev/null' to avoid the logs entirely.
* :log_level  
  Value is Fixnum - Default is 1 (Logger::INFO) - See Logger from Ruby standard Library

```ruby
openstack = Misty::Cloud.new(:auth => auth, :content_type => :ruby, :log_file => STDOUT)
```

### Services Options
Each service can get options specifically:

```ruby
openstack = Misty::Cloud.new(:auth => auth, :identity => {}, :compute => {})
```

The following options are available:
* :api_version  
  The latest supported version is used by default. See Misty.services to use another version.  
  Value is a STRING  
* :base_path  
  Allows to force the base path for every URL requests.  
  Value is a STRING
* :base_url  
  Allows to force the base URL for every requests.  
  Value is a STRING
* :interface  
  Allows to provide an alternate interface. Allowed values are "public", "internal" or "admin"  
  Value is a STRING - Default = "public"
* :region_id  
  Value is a STRING  
  Default "regionOne"
* :service_names  
  Value is a STRING - Default is defined by Misty.services  
  Allows to use a difference name for the service. For instance "identity3" for the identity service.
* :ssl_verify_mode  
  Used in SSL mode (detected from the URI)  
  Value is a BOOLEAN - Default is `true`
* :version  
  Version to be used when microversion is supported by the service.  
  Value is a STRING - Default is `"CURRENT"`  
  Allowed values are "CURRENT", "LATEST", "SUPPORTED", or a version number such as "2.0" or "3"

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
* Ruby 2.4.0
* Ruby 2.3.3
* Ruby 2.3.0
* Ruby 2.2.0

# Contributing
Contributors are welcome and must adhere to the [Contributor covenant code of conduct](http://contributor-covenant.org/).

Please submit issues/bugs and patches on the [Misty repository](https://github.com/flystack/misty).

# Copyright
Copyright © 2007 Free Software Foundation, Inc. See [LICENSE](LICENSE.md) for details.
