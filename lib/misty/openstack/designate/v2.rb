require 'misty/http/client'
require 'misty/openstack/designate/designate_v2'

module Misty
  module Openstack
    module Designate
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::DesignateV2

        def self.api
          v2
        end

        def self.service_names
          %w{dns}
        end
      end
    end
  end
end
