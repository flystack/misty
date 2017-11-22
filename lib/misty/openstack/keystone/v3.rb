require 'misty/openstack/keystone/keystone_v3'
require 'misty/openstack/keystone/keystone_v3_ext'
require 'misty/client_pack'

module Misty
  module Openstack
    module Keystone
      class V3
        extend Misty::Openstack::KeystoneV3
        include Misty::ClientPack

        def api
          all = self.class.v3
          all.merge!(self.class.v3_ext)
          all
        end

        def service_names
          %w{identity}
        end
      end
    end
  end
end
