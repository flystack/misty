require 'misty/openstack/api/cinder/cinder_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Cinder
        class V1
          include Misty::Openstack::API::CinderV1
          include Misty::Openstack::ServicePack

          def prefix_path_to_ignore
            '/v1/{admin_tenant_id}/'
          end

          def service_types
            %w(volume)
          end
        end
      end
    end
  end
end
