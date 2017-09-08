require 'misty/http/client'
require 'misty/openstack/microversion'
require 'misty/openstack/magnum/magnum_v1'

module Misty
  module Openstack
    module Magnum
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::MagnumV1
        include Misty::HTTP::Microversion

        def self.api
          v1
        end

        def self.service_names
          %w{container}
        end
      end
    end
  end
end
