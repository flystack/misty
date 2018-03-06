# Introduction
Misty is a HTTP client for OpenStack APIs, aiming to be slick and dynamic.

Misty handles OpenStack APIs requests as Transparently as possible by:
* Directly submitting request to Openstack Service endpoints
* Or by using APIs Schema defined functions which are dynamically extracted from OpenStackAPI reference.

## Features
* Standardized OpenStack APIs: [Based upon API-ref](https://developer.openstack.org/api-guide/quick-start/) it offers
  the flexibility to easily integrate new OpenStack services. Any request can be overridden or completed
* Versions and Microversions
* Transparent Request data handling
* Response data format of choice: JSON or Hash
* Custom HTTP Methods for special needs
* On demand services - Auto loads required versions
* Low dependency - Use standard Net/HTTP and JSON gem only
* Persistent HTTP connections (default since HTTP 1.1 anyway)

# How To
Fetch and install
``` ruby
gem install misty
```
## Get started
Create a `Misty::Cloud` object with mandatory `:auth` parameter such as:

```ruby
require 'misty'
cloud = Misty::Cloud.new(
  :auth => {
    :url                => 'http://localhost:5000',
    :user               => 'admin',
    :password           => 'secret',
    :domain             => 'default',
    :project            => 'admin',
    :project_domain_id  => 'default'
  })
  ```

  Then requets can be made against OpenStack services:

```
  servers = cloud.compute.list_servers.body
  networks = cloud.networking.list_networks
  first_network_id = networks.body['networks'][0]['id']
  first_network = cloud.networking.show_network_details(first_network_id)
  network = Misty.to_json(:network => {:name => 'misty-example'})
  cloud.network.create_network(network)
  v1 = cloud.baremetal.show_v1_api
```

## Authentication
Openstack Identity service Keystone version 3 is the default, version 2.0, although deprecated, is available.

### Parameters
The following parameters can be used:
To authenticate with credentials details:
* `:context` - Allow to provide already authenticated context(catalog, token, expiry time). Used for v2.0 only.
  Exclusive with other parameters.
* `:domain_id` - Domain id, default: "default"
* `:domain` - Domain name, default: "Default"
* `:password` - User password. Exclusive with :token.
* `:project_id` - Project id
* `:project` - Project name
* `:project_domain_id` - Project domain id
* `:project_domain` - Project domain name
* `:ssl_verify_mode` - Boolean flag for SSL client verification. SSL is defined when URI scheme => "https://".
* `:tenant_id` - Tenant id, used for v2.0 only.
* `:tenant` - Tenant name, used for v2.0 only.
* `:user_id` - User id
* `:user` - User name
* `:user_domain_id` - User domain id
* `:user_domain` - User domain name

#### Keystone v3
Version 3 relies on the concept of domain name or id to authenticates

`Misty::AuthV3` is used by default unless authentication credentials contains a tenant name or id in wich case it
will use on `Misty::AuthV2`.

The credentials are a combination of "id" and "name" used to uniquely identify projects, users and their domains.
When using only the name, a domain must be specified to guarantee a unique record from the Identity service.

##### Examples
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
cloud = Misty::Cloud.new(:auth => auth_v3)
# The API requests are of course specific to this version:
cloud.identity.list_projects
```

Using IDs:
```ruby
auth = {
  :url        => 'http://localhost:5000',
  :user_id    => '48985e6b8da145699d411f12a3459fca',
  :password   => 'secret',
  :project_id => '8e1e232f6cbb4116bbef715d8a0afe6e',
  }
}
```

Or alternatively using a context
```ruby
context = { :context => { :token => token_id, :catalog => service_catalog, :expires => expire_date } }
cloud = Misty::Cloud.new(:auth => context)
```

#### Keystone v2.0
By providing tenant details Misty will detect it's using v2.0 for authentication:

```ruby
auth = {
  :url      => 'http://localhost:5000',
  :user     => 'admin',
  :password => 'secret',
  :tenant   => 'admin',
}
cloud = Misty::Cloud.new(:auth => auth_v2)
# The API requests are of course specific to this version:
cloud.identity.list_tenants
```

#### Note
It's possible to authenticate against Keystone V3 and use the identity service v2.0, for instance:
In which case API set for v2.0 applies: tenants are available but not the projects.
```ruby
cloud = Misty::Cloud.new(:auth => auth_v3)
cloud.identity(:api_version => 'v2.0')
```

## Global configuration options
The configuration parameters used to initialize `Misty::Cloud` are global. They are optionals and Misty::Config
defaults are applied if needed.

* `:auth` - Authentication credentials hash containing 'auth_url' and user context. See `Misty::Auth`.
* `:content_type` - HTTP responses body format. :json or :hash structures. Default is `Misty::Config::CONTENT_TYPE`.
* `:headers` - Hash of extra HTTP headers to be applied to all services
* `:interface` - Endpoint interface, allowed values are: "public", "internal", "admin".
* `:log_file` - Log destination, Value is either file path (./misty.log) or IO object (SDOUT). Default is '/dev/null'
* `:log_level` - Value is Fixnum - Default is 1 (Logger::INFO) - See Logger from Ruby standard Library
* `:region_id` - Alternative Region identifier. Default is `Misty::Config::REGION_ID`
   Default is `Misty::Config::INTERFACE`
* `:ssl_verify_mode` - Boolean flag for SSL client verification. SSL is defined when URI scheme => "https://".
   Default is `Misty::Config::SSL_VERIFY_MODE`
   See `Misty::Config` for more details

### Headers
Headers are cumulative, applied from Cloud top level, then at Service level and finally at request level.

HTTP headers can effectively be optionally added to any request.
An Header object must be created and passed as the last parameter of a request.

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

## Services
The latest list of supported service can be obtain following this:
```
require 'misty'
puts Misty.services
=>
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
dns: designate, versions: ["v2"]
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

### Service level configuration parameters
The same parameters used at the global configuration variables can be applied at Service level.
The global values passed from +Misty::Cloud+ level are then overridden at the Service level.

Also, the following parameters can be used:
* `:api_version` - String for specifying Openstack API service version to use. Default is latest supported version.
* `:base_path` - Allows to force the base path for every URL requests Default nil.
* `:base_url` - Allows to force the base URL for every requests. Default nil.
* `:version` - Version to be used when microversion is supported by the service. Default: `"CURRENT"`
  Allowed values: "CURRENT", "LATEST", "SUPPORTED", or a version number such as "2.0" or "3"

#### Examples
Initialize cloud
```ruby
cloud = Misty::Cloud.new(:auth => { ... }, region_id => 'regionOne', :log_level => 0)
```

Then use different options, for example, the identify service, therefore overriding respective global defaults or
specified values
```ruby
 cloud.identity => {:region_id => 'regionTwo', :interface => 'admin'}
Provide service specific option
 cloud.compute  => {:version => '2.27'})
```
### Service short cut - Prefixes
A shorter name can be used to call a service only if it's unique among all services.
For instance `net` or `network` can be used instead of `networking` because it's not ambiguous.
Meanwhile `data` doesn't work because it's ambiguous between `data_processing` and `data_protection_orchestration`

### Aliases  
* `domain_name_server` is an alias for `dns`
* `volume` is an alias for `block_storage`

### Requests
The exhaustive list of requests, extracted from the current service API's and cumulated with Misty service defined
requests if any, is available as follow:

#### Example (Output truncated)
```
cloud.compute.requests
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
```

### Direct HTTP requests to REST resources
To send requests directly use the 'get', 'delete', 'post' and 'put' methods directly:
```ruby
openstack.network.post('/v2.0/qos/policies/48985e6b8da145699d411f12a3459fca/dscp_marking_rules', data)
```

### Orchestration
#### Example
```ruby
heat_template = {
  "files": {},
  "disable_rollback": true,
  "parameters": {
    "flavor": "m1.tiny"
  },
  "stack_name": "test_stack",
  "template": {
    "heat_template_version": "2013-05-23",
    "description": "Template to test heat",
    "parameters": {
      "flavor": {
        "default": "m1.small",
        "type": "string"
      }
    },
    "resources": {
      "hello_world": {
        "type": "OS::Nova::Server",
        "properties": {
          "flavor": { "get_param": "flavor" },
          "image": "50fd6f2b-d9f0-41b6-b0a9-4482bfe61914",
          "user_data": "/bin/bash -xv\necho \"hello world\" &gt; /root/hello-world.txt\n"
        }
      }
    }
  },
  "timeout_mins": 60
}
    cloud = Misty::Cloud.new(:auth => { ... })
data_heat_template = Misty.to_json(heat_template)
response = cloud.orchestration.create_stack(data_heat_template)
id = response.body['stack']['id']
    stack = cloud.orchestration.show_stack_details('test_stack', id)
pp stack.body
```

# OpenstackAPI notes
## Neutron
Driver Vendor Passthru (drivers) has 2 methods call with same name.
One for Node Vendor Passthru and one for Drivers Passthru.
They are respectively associated with the methods #call_a_vendor_method and #call_a_driver_method.

# Ruby versions tested
* Ruby MRI 2.5.0
* Ruby MRI 2.4.2
* Ruby MRI 2.3.4

# Contributing
Contributors are welcome and must adhere to the [Contributor covenant code of conduct](http://contributor-covenant.org/).

Please submit issues/bugs and patches on the [Misty repository](https://github.com/flystack/misty).

# Copyright
Apache License Version 2.0, January 2004 http://www.apache.org/licenses/ - See [LICENSE](LICENSE.md) for details.
