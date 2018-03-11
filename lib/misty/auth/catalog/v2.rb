require 'misty/auth/catalog'

module Misty
  module Auth
    module Catalog
      class V2
        include Misty::Auth::Catalog

        def endpoint_url(endpoint, region, interface)
          endpoint["#{interface}URL"] if endpoint['region'] == region && endpoint["#{interface}URL"]
        end
      end
    end
  end
end
