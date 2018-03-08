require 'misty/openstack/ceilometer/ceilometer_v2'
require 'misty/client_pack'

module Misty
  module Openstack
    module Ceilometer
      class V2
        include Misty::Openstack::CeilometerV2
        include Misty::ClientPack

        def service_types
          %w(meter metering telemetry)
        end
      end
    end
  end
end
