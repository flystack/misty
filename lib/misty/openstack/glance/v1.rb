require 'misty/openstack/glance/glance_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Glance
      class V1
        extend Misty::Openstack::GlanceV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def service_names
          %w{image}
        end
      end
    end
  end
end
