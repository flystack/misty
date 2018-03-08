require 'misty/openstack/glance/glance_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Glance
      class V2
        include Misty::Openstack::GlanceV2
        include Misty::ClientPack

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
