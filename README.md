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
See [Misty Cloud](https://flystack.github.io/misty/Misty/Cloud.html).

## Services

To see the list of [supported services](https://flystack.github.io/misty/Misty.html).

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
* `domain_name_server` is an alias for `dns`
* `volume` is an alias for `block_storage`  

## Openstack service name
Different service names can be used for a specific Openstack Service by using the :service_names option (see below).

## List Requests
See [Client requests](https://flystack.github.io/misty/Misty/Cloud.html#rl#method-i-requests).

## Setup

### Authentication information parameter

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

```ruby
openstack = Misty::Cloud.new(:auth => auth, :content_type => :ruby, :log_file => STDOUT)
```

#### Global parameters
See [Cloud configuration parameters](https://flystack.github.io/misty/Misty/Config.html).

### Service parameters
Each service can have specific parameters some of them overriding global parameters.

```ruby
openstack.identity(:version => '2.0')
openstack.compute(:version => '2.15')
```

For more information see [Service parameters](https://flystack.github.io/misty//Misty/Client.html)

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
