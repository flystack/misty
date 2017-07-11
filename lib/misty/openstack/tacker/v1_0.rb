require 'misty/http/client'
require "misty/openstack/tacker/tacker_v1_0"

module Misty
  module Openstack
    module Tacker
      class V1_0 < Misty::HTTP::Client
        extend Misty::Openstack::TackerV1_0

        def self.api
          v1_0
        end

        def self.service_names
          %w{nfv-orchestration}
        end
      end
    end
  end
end
