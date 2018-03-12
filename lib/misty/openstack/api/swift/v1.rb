require 'misty/openstack/api/swift/swift_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Swift
        class V1
          include  Misty::Openstack::API::SwiftV1
          include Misty::Openstack::ServicePack

          def prefix_path_to_ignore
            '/v1/{account}'
          end

          def service_types
            %w(object-store)
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
end
