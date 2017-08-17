require 'misty/http/client'
require 'misty/openstack/karbor/karbor_v1'

module Misty
  module Openstack
    module Karbor
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::KarborV1

        def self.api
          v1
        end

        def self.service_names
          %w{data-protection data-protection-orchestration}
        end
      end
    end
  end
end
