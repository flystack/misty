require 'misty/openstack/api/placement/placement_v2_1'
require 'misty/openstack/service_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module API
      module Placement
        class V2_1
          include Misty::Openstack::API::PlacementV2_1
          include Misty::Openstack::ServicePack
          include Misty::Microversion

          def service_types
            %w(placement)
          end
        end
      end
    end
  end
end
