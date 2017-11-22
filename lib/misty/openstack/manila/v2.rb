require 'misty/openstack/manila/manila_v2'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Manila
      class V2
        extend Misty::Openstack::ManilaV2
        include Misty::ClientPack
        include Misty::Microversion

        def api
          self.class.v2
        end

        def service_names
          %w{shared-file-systems shared}
        end
      end
    end
  end
end
