require 'misty/http/client'
require 'misty/openstack/neutron/neutron_v2_0'

module Misty
  module Openstack
    module Neutron
      class V2_0 < Misty::HTTP::Client
        extend Misty::Openstack::NeutronV2_0

        def self.api
          v2_0
        end

        def self.service_names
          %w{network networking}
        end
      end
    end
  end
end
