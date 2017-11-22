require 'misty/openstack/neutron/neutron_v2_0'
require 'misty/client_pack'

module Misty
  module Openstack
    module Neutron
      class V2_0
        extend Misty::Openstack::NeutronV2_0
        include Misty::ClientPack

        def api
          self.class.v2_0
        end

        def service_names
          %w{network networking}
        end
      end
    end
  end
end
