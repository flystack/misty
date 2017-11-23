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

        def service_names
          %w{container}
        end
      end
    end
  end
end
