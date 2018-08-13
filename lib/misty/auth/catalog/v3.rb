require 'misty/auth/catalog'

module Misty
  module Auth
    module Catalog
      class V3
        include Misty::Auth::Catalog

        def endpoint_match(endpoint, interface, region)
          if region
            return true if endpoint['interface'] == interface && endpoint['region'] == region
          else
            return true if endpoint['interface'] == interface
          end
        end

        def endpoint_url(endpoint, _)
          endpoint['url']
        end
      end
    end
  end
end
