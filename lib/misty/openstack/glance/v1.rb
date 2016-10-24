require 'misty/http/client'
require "misty/openstack/glance/glance_v1"

module Misty
  module Openstack
    module Glance
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::GlanceV1

        def self.api
          v1
        end

        def self.service_names
          %w{image}
        end
      end
    end
  end
end
