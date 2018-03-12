require 'misty/openstack/api/glance/glance_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Glance
        class V2
          include Misty::Openstack::API::GlanceV2
          include Misty::Openstack::ServicePack

          def service_types
            %w(image)
          end

          # Custom requests
          def list_images
            show_images
          end
        end
      end
    end
  end
end
