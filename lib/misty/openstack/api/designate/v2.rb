require 'misty/openstack/api/designate/designate_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Designate
        class V2
          include Misty::Openstack::API::DesignateV2
          include Misty::Openstack::ServicePack

          def service_types
            %w(dns)
          end
        end
      end
    end
  end
end
