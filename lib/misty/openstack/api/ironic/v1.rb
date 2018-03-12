require 'misty/openstack/api/ironic/ironic_v1'
require 'misty/openstack/service_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module API
      module Ironic
        class V1
          include Misty::Openstack::API::IronicV1
          include Misty::Openstack::ServicePack
          include Misty::Microversion

          def microversion_header(version)
            {'X-Openstack-Ironic-API-Version' => "#{version}"}
          end

          def service_types
            %w(baremetal)
          end
        end
      end
    end
  end
end
