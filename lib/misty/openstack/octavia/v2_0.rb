require 'misty/openstack/octavia/octavia_v2_0'
require 'misty/client_pack'

module Misty
  module Openstack
    module Octavia
      class V2_0
        include Misty::Openstack::OctaviaV2_0
        include Misty::ClientPack

        def service_names
          %w{load-balancer}
        end
      end
    end
  end
end
