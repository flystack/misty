require 'misty/openstack/keystone/keystone_v2_0'
require 'misty/openstack/keystone/keystone_v2_0_ext'
require 'misty/client_pack'
require 'misty/openstack/extension'

module Misty
  module Openstack
    module Keystone
      class V2_0
        include Misty::Openstack::KeystoneV2_0
        include Misty::Openstack::KeystoneV2_0_ext
        include Misty::ClientPack
        include Misty::Openstack::Extension

        def service_names
          %w{identity}
        end
      end
    end
  end
end
