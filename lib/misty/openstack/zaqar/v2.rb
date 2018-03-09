require 'misty/openstack/zaqar/zaqar_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Zaqar
      class V2
        include Misty::Openstack::ZaqarV2
        include Misty::Openstack::ServicePack

        def service_types
          %w(message messaging)
        end
      end
    end
  end
end
