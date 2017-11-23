require 'misty/openstack/keystone/keystone_v3'
require 'misty/openstack/keystone/keystone_v3_ext'
require 'misty/openstack/extension'
require 'misty/client_pack'

module Misty
  module Openstack
    module Keystone
      class V3
        include Misty::Openstack::KeystoneV3
        include Misty::Openstack::KeystoneV3_ext
        include Misty::ClientPack
        include Misty::Openstack::Extension

        def service_names
          %w{identity}
        end
      end
    end
  end
end
