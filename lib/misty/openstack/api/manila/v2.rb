require 'misty/openstack/api/manila/manila_v2'
require 'misty/openstack/service_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module API
        module Manila
        class V2
          include Misty::Openstack::API::ManilaV2
          include Misty::Openstack::ServicePack
          include Misty::Microversion

          def microversion
            '2.40'
          end

          def microversion_header(version)
            {'X-Openstack-Manila-API-Version' => "#{version}"}
          end

          def service_types
            %w(shared-file-system share sharev2)
          end
        end
      end
    end
  end
end
