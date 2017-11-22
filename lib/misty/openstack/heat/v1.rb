require 'misty/openstack/heat/heat_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Heat
      class V1
        extend Misty::Openstack::HeatV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def prefix_path_to_ignore
          '/v1/{tenant_id}'
        end

        def service_names
          %w{orchestration}
        end
      end
    end
  end
end
