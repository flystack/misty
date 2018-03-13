require 'misty/openstack/api/keystone/keystone_v3'
require 'misty/openstack/api/keystone/keystone_v3_ext'
require 'misty/openstack/service_pack'
require 'misty/openstack/extension'

module Misty
  module Openstack
    module API
      module Keystone
        class V3
          include Misty::Openstack::API::KeystoneV3
          include Misty::Openstack::API::KeystoneV3_ext
          include Misty::Openstack::ServicePack
          include Misty::Openstack::Extension

          def service_types
            %w(identity identityv3)
          end
        end
      end
    end
  end
end
