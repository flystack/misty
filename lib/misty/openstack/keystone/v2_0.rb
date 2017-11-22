require 'misty/openstack/keystone/keystone_v2_0'
require 'misty/openstack/keystone/keystone_v2_0_ext'
require 'misty/client_pack'

module Misty
  module Openstack
    module Keystone
      class V2_0
        extend Misty::Openstack::KeystoneV2_0
        include Misty::ClientPack

        def api
          all = self.class.v2_0
          all.merge!(self.class.v2_0_ext)
          all
        end

        def service_names
          %w{identity}
        end
      end
    end
  end
end
