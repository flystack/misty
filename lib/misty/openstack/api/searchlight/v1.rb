require 'misty/openstack/api/searchlight/searchlight_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Searchlight
        class V1
          include Misty::Openstack::API::SearchlightV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(search)
          end
        end
      end
    end
  end
end
