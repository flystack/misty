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

        def prefix_path_to_ignore
          '/v3/{tenant_id}'
        end

        def service_names
          %w{block-storage, block-store, volume}
        end
      end
    end
  end
end
