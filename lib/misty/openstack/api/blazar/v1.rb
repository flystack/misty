require 'misty/openstack/api/blazar/blazar_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Blazar
        class V1
          include Misty::Openstack::API::BlazarV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(reservation)
          end
        end
      end
    end
  end
end
