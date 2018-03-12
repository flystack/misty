require 'misty/openstack/keystone/keystone_v2_0'
require 'misty/openstack/keystone/keystone_v2_0_ext'
require 'misty/openstack/service_pack'
require 'misty/openstack/extension'

module Misty
  module Openstack
    module Keystone
      class V2_0
        include Misty::Openstack::KeystoneV2_0
        include Misty::Openstack::KeystoneV2_0_ext
        include Misty::Openstack::ServicePack
        include Misty::Openstack::Extension

        def service_types
          %w(identity)
        end
      end
    end
  end
end
