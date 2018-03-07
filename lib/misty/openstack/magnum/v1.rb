require 'misty/openstack/magnum/magnum_v1'
require 'misty/client_pack'
require 'misty/openstack/microversion'

module Misty
  module Openstack
    module Magnum
      class V1
        include Misty::Openstack::MagnumV1
        include Misty::ClientPack
        include Misty::HTTP::Microversion

        def microversion
          '1.4'
        end

        def service_names
          %w{container-infrastructure-management container-infrastructure}
        end
      end
    end
  end
end
