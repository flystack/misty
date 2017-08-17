require 'misty/http/client'
require 'misty/openstack/freezer/freezer_v1'

module Misty
  module Openstack
    module Freezer
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::FreezerV1

        def self.api
          v1
        end

        def self.service_names
          %w{backup}
        end
      end
    end
  end
end
