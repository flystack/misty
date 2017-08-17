require 'misty/http/client'
require 'misty/openstack/keystone/keystone_v3'
require 'misty/openstack/keystone/keystone_v3_ext'

module Misty
  module Openstack
    module Keystone
      class V3 < Misty::HTTP::Client
        extend Misty::Openstack::KeystoneV3

        def self.api
          api = v3
          api.merge!(v3_ext)
          api
        end

        def self.service_names
          %w{identity}
        end
      end
    end
  end
end
