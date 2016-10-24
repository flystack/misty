require 'misty/http/client'
require 'misty/openstack/microversion'
require "misty/openstack/manila/manila_v2"

module Misty
  module Openstack
    module Manila
        class V2 < Misty::HTTP::Client
          extend Misty::Openstack::ManilaV2
          include Misty::HTTP::Microversion

        def self.api
          v2
        end

        def self.service_names
          %w{shared-file-systems shared}
        end

        def microversion_header
          { "X-Openstack-Manila-API-Version" => "#{@version}" }
        end
      end
    end
  end
end
