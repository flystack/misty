require 'misty/openstack/api/barbican/barbican_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Barbican
        class V1
          include Misty::Openstack::API::BarbicanV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(key-manager)
          end
        end
      end
    end
  end
end
