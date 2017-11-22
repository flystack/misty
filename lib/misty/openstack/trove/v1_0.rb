require 'misty/openstack/trove/trove_v1_0'
require 'misty/client_pack'

module Misty
  module Openstack
    module Trove
      class V1_0
        extend Misty::Openstack::TroveV1_0
        include Misty::ClientPack

        def api
          self.class.v1_0
        end

        def service_names
          %w{database}
        end
      end
    end
  end
end
