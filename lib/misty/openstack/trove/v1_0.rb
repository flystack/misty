require 'misty/http/client'
require "misty/openstack/trove/trove_v1_0"

module Misty
  module Openstack
    module Trove
      class V1_0 < Misty::HTTP::Client
        extend Misty::Openstack::TroveV1_0

        def self.api
          v1_0
        end

        def self.service_names
          %w{database}
        end
      end
    end
  end
end
