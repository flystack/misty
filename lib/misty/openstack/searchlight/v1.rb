require 'misty/http/client'
require 'misty/openstack/searchlight/searchlight_v1'

module Misty
  module Openstack
    module Searchlight
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::SearchlightV1

        def self.api
          v1
        end

        def self.service_names
          %w{search}
        end
      end
    end
  end
end
