require 'misty/openstack/api/magnum/magnum_v1'
require 'misty/openstack/service_pack'
require 'misty/openstack/api/microversion'

module Misty
  module Openstack
    module API
      module Magnum
        class V1
          include Misty::Openstack::API::MagnumV1
          include Misty::Openstack::ServicePack
          include Misty::HTTP::Microversion

          def microversion
            '1.4'
          end

          def service_types
            %w(container-infrastructure-management container-infrastructure)
          end
        end
      end
    end
  end
end
