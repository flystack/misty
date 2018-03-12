require 'misty/openstack/api/freezer/freezer_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Freezer
        class V1
          include Misty::Openstack::API::FreezerV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(backup)
          end
        end
      end
    end
  end
end
