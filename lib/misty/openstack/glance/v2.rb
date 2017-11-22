require 'misty/openstack/glance/glance_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Glance
      class V2
        extend Misty::Openstack::GlanceV2
        include Misty::ClientPack

        def api
          self.class.v2
        end

        def service_names
          %w{image}
        end
      end
    end
  end
end
