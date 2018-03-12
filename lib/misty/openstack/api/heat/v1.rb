require 'misty/openstack/api/heat/heat_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Heat
        class V1
          include Misty::Openstack::API::HeatV1
          include Misty::Openstack::ServicePack

          def prefix_path_to_ignore
            '/v1/{tenant_id}'
          end

          def service_types
            %w(orchestration)
          end
        end
      end
    end
  end
end
