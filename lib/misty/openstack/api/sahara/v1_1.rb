require 'misty/openstack/api/sahara/sahara_v1_1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Sahara
        class V1_1
          include Misty::Openstack::API::SaharaV1_1
          include Misty::Openstack::ServicePack

          def service_types
            %w(data-processing)
          end
        end
      end
    end
  end
end
