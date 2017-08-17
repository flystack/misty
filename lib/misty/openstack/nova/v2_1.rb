require 'misty/http/client'
require 'misty/openstack/microversion'
require 'misty/openstack/nova/nova_v2_1'

module Misty
  module Openstack
    module Nova
      class V2_1 < Misty::HTTP::Client
        extend Misty::Openstack::NovaV2_1
        include Misty::HTTP::Microversion

        def self.api
          v2_1
        end

        # Overrides API because the definitions don't specify prefix
        def self.list_all_major_versions
          http_get('/', headers)
        end

        def self.show_details_of_specific_api_version(version)
          http_get("/#{version}", headers)
        end

        def self.service_names
            %w{compute}
        end

        def microversion_header
          {
            # Remove once depcrecated
            'X-Openstack-Nova-API-Version' => "#{@version}",
            # From version 2.27 the OpenStack-API-Version is used
            'X-Openstack-API-Version' => "#{baseclass.downcase} #{@version}"
          }
        end
      end
    end
  end
end
