require 'misty/openstack/heat/heat_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Heat
      class V1
        include Misty::Openstack::HeatV1
        include Misty::ClientPack

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
