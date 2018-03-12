require 'misty/openstack/aodh/aodh_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Aodh
      class V2
        include Misty::Openstack::AodhV2
        include Misty::Openstack::ServicePack

        def service_types
          %w(alarming alarm)
        end
      end
    end
  end
end
