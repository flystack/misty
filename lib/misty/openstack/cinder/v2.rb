require 'misty/http/client'
require "misty/openstack/cinder/cinder_v2"

module Misty
  module Openstack
    module Cinder
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::CinderV2

        def self.api
          v2
        end

        def self.prefix_path_to_ignore
          "/v2/{tenant_id}"
        end

        def self.service_names
          %w{block-storage, block-store, volume}
        end
      end
    end
  end
end
