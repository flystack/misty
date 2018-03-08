require 'misty/openstack/trove/trove_v1_0'
require 'misty/client_pack'

module Misty
  module Openstack
    module Trove
      class V1_0
        include Misty::Openstack::TroveV1_0
        include Misty::ClientPack

        def service_types
          %w(database)
        end
      end
    end
  end
end
