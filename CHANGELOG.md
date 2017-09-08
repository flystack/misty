# 0.9.1 - 8 Septembre 2017
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
