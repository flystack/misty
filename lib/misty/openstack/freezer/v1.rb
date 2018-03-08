require 'misty/openstack/freezer/freezer_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Freezer
      class V1
        include Misty::Openstack::FreezerV1
        include Misty::ClientPack

        def service_types
          %w(backup)
        end
      end
    end
  end
end
