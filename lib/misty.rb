require 'json'
require 'net/http'
require 'time'
require 'uri'
require 'misty/misty'

module Misty
  module Auth
    module Token
      autoload :V2, 'misty/auth/token/v2'
      autoload :V3, 'misty/auth/token/v3'
    end

    module Catalog
      autoload :V2, 'misty/auth/catalog/v2'
      autoload :V3, 'misty/auth/catalog/v3'
    end
  end

  module Openstack
    module API
      module Aodh
        autoload :V2, 'misty/openstack/api/aodh/v2'
      end

      module Ceilometer
        autoload :V2, 'misty/openstack/api/ceilometer/v2'
      end

      module Cinder
        autoload :V1, 'misty/openstack/api/cinder/v1'
        autoload :V2, 'misty/openstack/api/cinder/v2'
        autoload :V3, 'misty/openstack/api/cinder/v3'
      end

      module Designate
        autoload :V2, 'misty/openstack/api/designate/v2'
      end

      module Freezer
        autoload :V1, 'misty/openstack/api/freezer/v1'
      end

      module Glance
        autoload :V1, 'misty/openstack/api/glance/v1'
        autoload :V2, 'misty/openstack/api/glance/v2'
      end

      module Heat
        autoload :V1, 'misty/openstack/api/heat/v1'
      end

      module Ironic
        autoload :V1, 'misty/openstack/api/ironic/v1'
      end

      module Karbor
        autoload :V1, 'misty/openstack/api/karbor/v1'
      end

      module Keystone
        autoload :V3,   'misty/openstack/api/keystone/v3'
        autoload :V2_0, 'misty/openstack/api/keystone/v2_0'
      end

      module Magnum
        autoload :V1, 'misty/openstack/api/magnum/v1'
      end

      module Manila
        autoload :V2, 'misty/openstack/api/manila/v2'
      end

      module Murano
        autoload :V1, 'misty/openstack/api/murano/v1'
      end

      module Neutron
        autoload :V2_0, 'misty/openstack/api/neutron/v2_0'
      end

      module Nova
        autoload :V2_1, 'misty/openstack/api/nova/v2_1'
      end

      module Octavia
        autoload :V2_0, 'misty/openstack/api/octavia/v2_0'
      end

      module Sahara
        autoload :V1_1, 'misty/openstack/api/sahara/v1_1'
      end

      module Searchlight
        autoload :V1, 'misty/openstack/api/searchlight/v1'
      end

      module Senlin
        autoload :V1, 'misty/openstack/api/senlin/v1'
      end

      module Swift
        autoload :V1, 'misty/openstack/api/swift/v1'
      end

      module Tacker
        autoload :V1_0, 'misty/openstack/api/tacker/v1_0'
      end

      module Trove
        autoload :V1_0, 'misty/openstack/api/trove/v1_0'
      end

      module Zaqar
        autoload :V2, 'misty/openstack/api/zaqar/v2'
      end
    end
  end
end

require 'misty/cloud'
require 'misty/errors'
