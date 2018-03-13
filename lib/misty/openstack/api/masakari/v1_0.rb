require 'misty/openstack/api/masakari/masakari_v1_0'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Masakari
        class V1_0
          include Misty::Openstack::API::MasakariV1_0
          include Misty::Openstack::ServicePack

          def service_types
            %w(instance-ha ha)
          end
        end
      end
    end
  end
end
