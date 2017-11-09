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

        def self.prefix_path_to_ignore
          '/v1/{account}'
        end

        def self.service_names
          %w{object-storage object-store}
        end

        # Custom requests
        api_add :bulk_delete

        def bulk_delete(data)
          param = 'bulk-delete=1'
          header = Misty::HTTP::Header.new('Content-Type' => 'text/plain')
          create_update_or_delete_account_metadata(param, data, header)
        end
      end
    end
  end
end
