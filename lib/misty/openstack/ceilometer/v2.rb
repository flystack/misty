require 'misty/http/client'
require 'misty/openstack/ceilometer/ceilometer_v2'

module Misty
  module Openstack
    module Ceilometer
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::CeilometerV2

        def self.api
          v2
        end

        def self.service_names
          %w{metering}
        end
      end
    end
  end
end
