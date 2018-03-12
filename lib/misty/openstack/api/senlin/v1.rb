require 'misty/openstack/api/senlin/senlin_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Senlin
        class V1
          include Misty::Openstack::API::SenlinV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(clustering resource-cluster cluster)
          end
        end
      end
    end
  end
end
