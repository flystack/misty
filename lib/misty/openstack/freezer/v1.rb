require 'misty/openstack/freezer/freezer_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Freezer
      class V1
        extend Misty::Openstack::FreezerV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def service_names
          %w{backup}
        end
      end
    end
  end
end
