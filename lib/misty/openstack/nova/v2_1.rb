require 'misty/openstack/nova/nova_v2_1'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Nova
      class V2_1
        extend Misty::Openstack::NovaV2_1
        include Misty::ClientPack
        include Misty::Microversion

        def api
          self.class.v2_1
        end

        # Overrides API because the definitions don't specify prefix
        def self.list_all_major_versions
          http_get('/', headers)
        end

        def self.show_details_of_specific_api_version(version)
          http_get("/#{version}", headers)
        end

        def service_names
            %w{compute}
        end

        def microversion_header
          # Versions 2.27+ use default OpenStack-API-Version
          header = super
          # For prior vesions then remove once depcrecated
          header.merge!('X-Openstack-Nova-API-Version' => "#{@version}",)
          header
        end
      end
    end
  end
end
