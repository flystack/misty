require 'misty/openstack/api/murano/murano_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Murano
        class V1
          include Misty::Openstack::API::MuranoV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(application-catalog)
          end
        end
      end
    end
  end
end
