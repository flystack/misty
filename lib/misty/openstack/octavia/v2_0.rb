require 'misty/http/client'
require 'misty/openstack/octavia/octavia_v2_0'

module Misty
  module Openstack
    module Octavia
      class V2_0 < Misty::HTTP::Client
        extend Misty::Openstack::OctaviaV2_0

        def self.api
          v2_0
        end

        def self.service_names
          %w{load-balancer}
        end
      end
    end
  end
end
