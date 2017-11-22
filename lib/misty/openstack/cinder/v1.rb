require 'misty/openstack/cinder/cinder_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Cinder
      class V1
        extend Misty::Openstack::CinderV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def prefix_path_to_ignore
          '/v1/{admin_tenant_id}/'
        end

        def service_names
          %w{block-storage, block-store, volume}
        end
      end
    end
  end
end
