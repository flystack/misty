# 1.5.3 - 23 March 2018
## Attribute readers
Added:
* :config for Cloud
* :expires, :user for Token
* :domain, :project for Token::V3
* :tenant for Token::V2

Removed unused :catalog from Config

## Rake
Removed unused rdoc task
Renamed build task to API
Added build and release tasks from bundler

# 1.5.2 - 15 March 2018
## Authentication
Fix case when provided domain name is overridden by default domain id

# 1.5.1 - 13 March 2018
## Misty#services
Replace openstack_services.yaml with Misty::Openstack::SERVICES

## Readme
Updated service list
Adjusted Services examples

# 1.5.0 - 13 March 2018
# Authentication
Catalog and Token classes added

# Services
Using official service types from https://service-types.openstack.org/service-types.json
Dedicated API directory.
Microversion revisited, with Misty.services microversion holding the latest supported.
Misty.services

Latest from Openstack-APIs which include new services which have been added:
- barbican
- blazar
- gnocchi
- masakari
- mistral
- monasca
- panko
- placement
- watcher
- zun

All other services updated

# 1.4.0 - 08 March 2018
Pre-release

# 1.3.4 - 07 March 2018
## CI
Added OpenLab app
https://openlabtesting.org/

## Cloud and Openstack Services configuration management
* Using prototyping instead of inheritance for Misty::Config module.
  Restructured the propagation of the parameter from top (defaults) to bottom (request) levels:
  At top level are the Defaults parameters
  At Cloud level are the Globals parameters
  At Service level are service specific parameters
  At Request level are the ephemeral parameters applying only for a request.
* Log
  * Fixed empty logs
  * Refactored

## Microversion
Using OpenStack API WG guidelines for version validation
Following microversion latest support
## Cinder - v3.44
## Ironic - v1.32
## Magnum - v1.4
## Manilla - v2.40
## Nova - v2.60

## Authentication
Fixed Project domain name issue which was ignored as project domain id was used instead by default
https://github.com/flystack/misty/issues/115

## Engine
Only Ruby MRI versions active are tested

## README
Updated to reflect above
Reorganized with how-to to reduce duplication and bring more consistency

# 1.3.3 - 07 February 2018
* Fixed Misty::Services.names

# 1.3.2 - Does not exist

# 1.3.1 - 06 February 2018
## Integration test
Fast forward expiry time stamp to fix expired token

# 1.3.0 - 06 February 2018
## Identity
Re-authenticate if token is expired

## APIs
APIs are tagged as they are retrieved during build process from "https://github.com/flystack/openstack-APIs"

# 1.2.0 - 23 November 2017
## HTTP Requests
JSON header automatically generated when data is Array or Hash

## APIs
* Wrapper requests allow to create requests for any API service
* Openstack APIs are now included as module (and not extended)
* Misty::Openstack::Extension module added (see Keystone)

### Swift
:bulk_delete wrapper added

### Keystone
API extensions for Keystone v2.0 and v3 are now fusioned into respective API.   

### Schema
The APIs schema are using https://github.com/flystack/openstack-APIs

## Rakefile
Build rules for fetch APIs schema.

## Auth
Misty::Auth re-factored as a mixin

# 1.1.0 - 26 October 2017
## HTTP Requests
* HEAD request fixed: no need for data

### Headers
Custom Headers can be injected at request level.
Global and Service level headers proper propagation  

# 1.0.0 - 10 October 2017
## HTTP Requests
Transplarent hanlding of data for POST, PUT and PATCH requests leaving the server to handle the formats.

## Ruby
Support for MRI 2.4.2

# 0.9.2 - 4 October 2017
## Gem
Minimum Ruby version added

## HTTP
Header re-factored and added to documentation

## Services
Re-factored Endpoint/URL with better Error management
Re-factored Microversion
Swift:
* Missed path prefix filter added
* Microversion added

## Tests
Suppressed Ruby warnings

# 0.9.1 - 8 September 2017
## Services
Removed redundant aliases `container` and `data_protection` as this is covered by prefixes.

# 0.9.0 - 7 September 2017
## Services
Service Class is explicitly using microversion parameter

Following services renamed:
`container` is now `container_infrastructure_management`
`data_protection` is now `data_protection_orchestration`
`dns` is now `domain_name_server`

Aliases added for `container`, `data_protection`, `dns`

## HTTP client
Makes proxy environment variable work again

# 0.8.0 - 17 August 2017
## APIs
HTTP request thread friendly

## Test
* Webmock version 2.3

## Miscellaneous
Consistent use of single quotes unless extrapolation needed

# 0.7.2 - 20 July 2017
## APIs
* Better message if API method doesn't exist

## Documentation
* README adjustments

# 0.7.1 - 18 July 2017
## APIs
### Neutron v2.0
* Adds RBAC

## Cloud class
* Removed unused `@Services`

# 0.7.0 - 06 July 2017
## Authentication
 Catalog and Token are accessible method for Auth object.

## Services
Service names can now use unique prefixed names (see README)

### New
* application-catalog: murano: v1
* backup: freezer: v1
* load-balancer: octavia: v2.0
* nfv-orchestration: tacker: v1.0

### Legacy new version
* block_storage: cinder: v2

### Updated
* block_storage: cinder: v3
* compute: nova: v2.1
* container-infrastructure-management: magnum: v1
* dns: designate: v2
* identity: keystone: v3
* networking: neutron: v2.0
* clustering: senlin: v1
* messaging: zaqar: v2

# 0.6.2 - 04 July 2017
## Authentication
* Keystone V3: project_domain enables to use the domain name of the project's instead of domain id.
* Allow predefined authentication (needs token, catalog)

# 0.6.1 - 29 May 2017
## Authentication
* Keystone V2.0: Support authentication with token (tenant scope)
* Keystone V3: Domain name scope fix

## Services
MISTY.services.to_s created to replace missing feature to list all services

# 0.6.0 - 15 May 2017
## HTTP client
Optional query argument accept hashes and empty strings.\

## Authentication
* HTTP Proxy option removed, reverted to http/net proxy defaults
* Token authentication

## Travis
RVMS support:
* 2.3.1
* 2.3.2
* 2.3.4
* 2.4.1

## Cloud service
Replaced Struct setup and options with classes

# 0.5.1 - 18 April 2017
## GEM
JSON dependencies lowered to 1.8.3
Specification changed for license field to use supported type

## Authentication
HTTP Proxy option available

# 0.5.0 - 12 April 2017
## Legal
Using Apache License Version 2.0
