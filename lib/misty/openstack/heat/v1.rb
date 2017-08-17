require 'misty/http/client'
require 'misty/openstack/heat/heat_v1'

module Misty
  module Openstack
    module Heat
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::HeatV1

        def self.api
          v1
        end

        def self.prefix_path_to_ignore
          '/v1/{tenant_id}'
        end

        def self.service_names
          %w{orchestration}
        end
      end
    end
  end
end
