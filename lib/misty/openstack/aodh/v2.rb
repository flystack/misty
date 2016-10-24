require 'misty/http/client'
require "misty/openstack/aodh/aodh_v2"

module Misty
  module Openstack
    module Aodh
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::AodhV2

        def self.api
          v2
        end

        def self.service_names
          %w{alarming}
        end
      end
    end
  end
end
