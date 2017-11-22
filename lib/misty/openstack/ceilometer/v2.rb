require 'misty/openstack/ceilometer/ceilometer_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Ceilometer
      class V2
        extend Misty::Openstack::CeilometerV2
        include Misty::ClientPack

        def api
          self.class.v2
        end

        def service_names
          %w{metering}
        end
      end
    end
  end
end
