require 'misty/http/client'
require "misty/openstack/cinder/cinder_v1"

module Misty
  module Openstack
    module Cinder
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::CinderV1

        def self.api
          v1
        end

        def self.prefix_path_to_ignore
          "/v1/{admin_tenant_id}/"
        end

        def self.service_names
          %w{block-storage, block-store, volume}
        end
      end
    end
  end
end
