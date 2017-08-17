require 'misty/http/client'
require 'misty/openstack/glance/glance_v2'

module Misty
  module Openstack
    module Glance
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::GlanceV2

        def self.api
          v2
        end

        def self.service_names
          %w{image}
        end
      end
    end
  end
end
