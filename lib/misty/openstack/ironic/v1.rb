require 'misty/http/client'
require 'misty/microversion'
require 'misty/openstack/ironic/ironic_v1'

module Misty
  module Openstack
    module Ironic
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::IronicV1
        include Misty::Microversion

        def self.api
          v1
        end

        def self.service_names
          %w{baremetal}
        end
      end
    end
  end
end
