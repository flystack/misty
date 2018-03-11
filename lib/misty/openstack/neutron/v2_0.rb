require 'misty/openstack/neutron/neutron_v2_0'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Neutron
      class V2_0
        include Misty::Openstack::NeutronV2_0
        include Misty::Openstack::ServicePack

        def service_types
          %w(network)
        end
      end
    end
  end
end
