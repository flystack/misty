require 'misty/openstack/glance/glance_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Glance
      class V1
        include Misty::Openstack::GlanceV1
        include Misty::Openstack::ServicePack

        def service_types
          %w(image)
        end
      end
    end
  end
end
