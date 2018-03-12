require 'misty/openstack/api/nova/nova_v2_1'
require 'misty/openstack/service_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module API
      module Nova
        class V2_1
          include Misty::Openstack::API::NovaV2_1
          include Misty::Openstack::ServicePack
          include Misty::Microversion

          # TODO: Verify
          # Overrides API because the definitions don't specify prefix
          def self.list_all_major_versions
            http_get('/', headers)
          end

          def self.show_details_of_specific_api_version(version)
            http_get("/#{version}", headers)
          end

          def microversion
            '2.60'
          end

          def microversion_header(version)
            # Use default 'OpenStack-API-Version' or older 'X-Openstack-Nova-API-Version'
            if @version >= '2.27'
              super
            else
              {'X-Openstack-Nova-API-Version' => "#{version}"}
            end
          end

          def service_types
            %w(compute)
          end
        end
      end
    end
  end
end
