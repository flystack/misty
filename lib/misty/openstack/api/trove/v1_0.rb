require 'misty/openstack/api/trove/trove_v1_0'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Trove
        class V1_0
          include Misty::Openstack::API::TroveV1_0
          include Misty::Openstack::ServicePack

          def service_types
            %w(database)
          end
        end
      end
    end
  end
end