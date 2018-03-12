require 'misty/openstack/murano/murano_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Murano
      class V1
        include Misty::Openstack::MuranoV1
        include Misty::Openstack::ServicePack

        def service_types
          %w(application-catalog)
        end
      end
    end
  end
end
