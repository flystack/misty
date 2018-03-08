require 'misty/openstack/designate/designate_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Designate
      class V2
        include Misty::Openstack::DesignateV2
        include Misty::ClientPack

        def service_types
          %w(dns)
        end
      end
    end
  end
end
