require 'misty/openstack/ironic/ironic_v1'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Ironic
      class V1
        extend Misty::Openstack::IronicV1
        include Misty::ClientPack
        include Misty::Microversion

        def api
          self.class.v1
        end

        def service_names
          %w{baremetal}
        end
      end
    end
  end
end
