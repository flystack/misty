require 'misty/openstack/zaqar/zaqar_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Zaqar
      class V2
        extend Misty::Openstack::ZaqarV2
        include Misty::ClientPack

        def api
          self.class.v2
        end

        def service_names
          %w{messaging}
        end
      end
    end
  end
end
