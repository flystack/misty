require 'misty/openstack/api/monasca/monasca_v2_0'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Monasca
        class V2_0
          include Misty::Openstack::API::MonascaV2_0
          include Misty::Openstack::ServicePack

          def service_types
            %w(monitoring)
          end
        end
      end
    end
  end
end
