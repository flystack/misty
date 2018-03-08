require 'misty/openstack/cinder/cinder_v3'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Cinder
      class V3
        include Misty::Openstack::CinderV3
        include Misty::ClientPack
        include Misty::Microversion

        def microversion
          '3.44'
        end

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
