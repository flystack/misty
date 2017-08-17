require 'misty/http/client'
require 'misty/openstack/zaqar/zaqar_v2'

module Misty
  module Openstack
    module Zaqar
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::ZaqarV2

        def self.api
          v2
        end

        def self.service_names
          %w{messaging}
        end
      end
    end
  end
end
