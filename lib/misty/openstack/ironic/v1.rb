require 'misty/openstack/ironic/ironic_v1'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Ironic
      class V1
        include Misty::Openstack::IronicV1
        include Misty::ClientPack
        include Misty::Microversion

        def service_names
          %w{baremetal}
        end
      end
    end
  end
end
