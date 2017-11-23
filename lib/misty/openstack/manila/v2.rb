require 'misty/openstack/manila/manila_v2'
require 'misty/client_pack'
require 'misty/microversion'

module Misty
  module Openstack
    module Manila
      class V2
        include Misty::Openstack::ManilaV2
        include Misty::ClientPack
        include Misty::Microversion

        def service_names
          %w{shared-file-systems shared}
        end
      end
    end
  end
end
