require 'misty/openstack/api/watcher/watcher_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Watcher
        class V1
          include Misty::Openstack::API::WatcherV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(resource-optimization infra-optim)
          end
        end
      end
    end
  end
end
