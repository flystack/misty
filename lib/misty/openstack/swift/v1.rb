require 'misty/http/client'
require 'misty/openstack/swift/swift_v1'

module Misty
  module Openstack
    module Swift
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::SwiftV1

        def self.api
          v1
        end

        def self.service_names
          %w{object-storage object-store}
        end
      end
    end
  end
end
