require 'misty/openstack/api/zun/zun_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Zun
        class V1
          include Misty::Openstack::API::ZunV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(application-container container)
          end
        end
      end
    end
  end
end
