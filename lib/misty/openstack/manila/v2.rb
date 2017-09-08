require 'misty/http/client'
require 'misty/microversion'
require 'misty/openstack/manila/manila_v2'

module Misty
  module Openstack
    module Manila
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::ManilaV2
        include Misty::Microversion

        def self.api
          v2
        end

        def self.service_names
          %w{shared-file-systems shared}
        end
      end
    end
  end
end
