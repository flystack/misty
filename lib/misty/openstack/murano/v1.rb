require 'misty/http/client'
require 'misty/openstack/murano/murano_v1'

module Misty
  module Openstack
    module Murano
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::MuranoV1

        def self.api
          v1
        end

        def self.service_names
          %w{application-catalog}
        end
      end
    end
  end
end
