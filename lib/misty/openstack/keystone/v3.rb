require 'misty/openstack/keystone/keystone_v3'
require 'misty/openstack/keystone/keystone_v3_ext'
require 'misty/openstack/extension'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Keystone
      class V3
        include Misty::Openstack::KeystoneV3
        include Misty::Openstack::KeystoneV3_ext
        include Misty::Openstack::ServicePack
        include Misty::Openstack::Extension

        def service_types
          %w(identity)
        end
      end
    end
  end
end
