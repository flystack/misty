require 'misty/http/client'
require 'misty/openstack/senlin/senlin_v1'

module Misty
  module Openstack
    module Senlin
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::SenlinV1

        def self.api
          v1
        end

        def self.service_names
          %w{clustering}
        end
      end
    end
  end
end
