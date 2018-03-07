require 'misty/openstack/swift/swift_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Swift
      class V1
        include  Misty::Openstack::SwiftV1
        include Misty::ClientPack

        def prefix_path_to_ignore
          '/v1/{account}'
        end

        def service_names
          %w{object-storage object-store}
        end

        # Custom requests
        def requests_custom
          [ :bulk_delete ]
        end

        def bulk_delete(data)
          param = 'bulk-delete=1'
          @request_headers.add('Content-Type' => 'text/plain')
          create_update_or_delete_account_metadata(param, data)
        end
      end
    end
  end
end
