require 'misty/openstack/api/panko/panko_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Panko
        class V2
          include Misty::Openstack::API::PankoV2
          include Misty::Openstack::ServicePack

          def service_types
            %w(event events)
          end
        end
      end
    end
  end
end
