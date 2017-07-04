module Misty
  module Openstack
    module Aodh
      autoload :V2, "misty/openstack/aodh/v2"
    end

    module Ceilometer
      autoload :V2, "misty/openstack/ceilometer/v2"
    end

    module Cinder
      autoload :V1, "misty/openstack/cinder/v1"
      autoload :V3, "misty/openstack/cinder/v3"
    end

    module Designate
      autoload :V2, "misty/openstack/designate/v2"
    end

    module Freezer
      autoload :V1, "misty/openstack/freezer/v1"
    end

    module Glance
      autoload :V1, "misty/openstack/glance/v1"
      autoload :V2, "misty/openstack/glance/v2"
    end

    module Heat
      autoload :V1, "misty/openstack/heat/v1"
    end

    module Ironic
      autoload :V1, "misty/openstack/ironic/v1"
    end

    module Karbor
      autoload :V1, "misty/openstack/karbor/v1"
    end

    module Keystone
      autoload :V3,   "misty/openstack/keystone/v3"
      autoload :V2_0, "misty/openstack/keystone/v2_0"
    end

    module Magnum
      autoload :V1, "misty/openstack/magnum/v1"
    end

    module Manila
      autoload :V2, "misty/openstack/manila/v2"
    end

    module Murano
      autoload :V1, "misty/openstack/murano/v1"
    end

    module Neutron
      autoload :V2_0, "misty/openstack/neutron/v2_0"
    end

    module Nova
      autoload :V2_1, "misty/openstack/nova/v2_1"
    end

    module Octavia
      autoload :V2_0, "misty/openstack/octavia/v2_0"
    end

    module Sahara
      autoload :V1_1, "misty/openstack/sahara/v1_1"
    end

    module Searchlight
      autoload :V1, "misty/openstack/searchlight/v1"
    end

    module Senlin
      autoload :V1, "misty/openstack/senlin/v1"
    end

    module Swift
      autoload :V1, "misty/openstack/swift/v1"
    end

    module Tacker
      autoload :V1_0, "misty/openstack/tacker/v1_0"
    end

    module Trove
      autoload :V1_0, "misty/openstack/trove/v1_0"
    end

    module Zaqar
      autoload :V2, "misty/openstack/zaqar/v2"
    end
  end
end
