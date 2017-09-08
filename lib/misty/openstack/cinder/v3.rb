require 'misty/http/client'
require 'misty/openstack/microversion'
require 'misty/openstack/cinder/cinder_v3'

module Misty
  module Openstack
    module Cinder
      class V3 < Misty::HTTP::Client
        extend Misty::Openstack::CinderV3
        include Misty::HTTP::Microversion

        def self.api
          v3
        end

        def self.prefix_path_to_ignore
          '/v3/{tenant_id}'
        end

        def self.service_names
          %w{block-storage, block-store, volume}
        end

        def microversion_header
          {'X-Openstack-API-Version' => "#{baseclass.downcase} #{@version}" }
        end
      end
    end
  end
end
