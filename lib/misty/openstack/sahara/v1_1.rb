require 'misty/http/client'
require 'misty/openstack/sahara/sahara_v1_1'

module Misty
  module Openstack
    module Sahara
      class V1_1 < Misty::HTTP::Client
        extend Misty::Openstack::SaharaV1_1

        def self.api
          v1_1
        end

        def self.service_names
          %w{data-processing}
        end
      end
    end
  end
end
