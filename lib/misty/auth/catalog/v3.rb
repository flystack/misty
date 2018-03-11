require 'misty/auth/catalog'

module Misty
  module Auth
    module Catalog
      class V3
        include Misty::Auth::Catalog

        def endpoint_url(endpoint, region, interface)
          endpoint['url'] if endpoint['region'] == region && endpoint['interface'] == interface
        end
      end
    end
  end
end
