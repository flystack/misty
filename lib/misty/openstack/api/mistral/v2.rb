require 'misty/openstack/api/mistral/mistral_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Mistral
        class V2
          include Misty::Openstack::API::MistralV2
          include Misty::Openstack::ServicePack

          def service_types
            %w(workflow workflowv2)
          end
        end
      end
    end
  end
end
