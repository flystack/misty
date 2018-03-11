require 'misty/openstack/octavia/octavia_v2_0'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Octavia
      class V2_0
        include Misty::Openstack::OctaviaV2_0
        include Misty::Openstack::ServicePack

        def service_types
          %w(load-balancer)
        end
      end
    end
  end
end
