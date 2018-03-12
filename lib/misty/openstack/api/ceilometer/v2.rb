require 'misty/openstack/api/ceilometer/ceilometer_v2'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Ceilometer
        class V2
          include Misty::Openstack::API::CeilometerV2
          include Misty::Openstack::ServicePack

          def service_types
            %w(meter metering telemetry)
          end
        end
      end
    end
  end
end
