require 'misty/openstack/api/cinder/cinder_v3'
require 'misty/openstack/service_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module API
      module Cinder
        class V3
          include Misty::Openstack::API::CinderV3
          include Misty::Openstack::ServicePack
          include Misty::Microversion

          def microversion_header(version)
            {'X-Openstack-Cinder-API-Version' => "#{version}"}
          end

          def prefix_path_to_ignore
            '/v3/{tenant_id}'
          end

          def service_types
            %w(volumev3 block-storage block-store)
          end
        end
      end
    end
  end
end
