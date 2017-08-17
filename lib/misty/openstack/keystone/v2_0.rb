require 'misty/http/client'
require 'misty/openstack/keystone/keystone_v2_0'
require 'misty/openstack/keystone/keystone_v2_0_ext'

module Misty
  module Openstack
    module Keystone
      class V2_0 < Misty::HTTP::Client
        extend Misty::Openstack::KeystoneV2_0

        def self.api
          api = v2_0
          api.merge!(v2_0_ext)
          api
        end

        def self.service_names
          %w{identity}
        end
      end
    end
  end
end
