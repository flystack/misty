require 'misty/auth'

module Misty
  class AuthV2 < Misty::Auth
    def self.path
      "/v2.0/tokens"
    end

    def catalog_endpoints(endpoints, region, interface)
      endpoints.each do |endpoint|
        if endpoint["region"] == region && endpoint["#{interface}URL"]
          return endpoint["#{interface}URL"]
        end
      end
    end

    def credentials_valid?(creds)
      true if creds[:user] && creds[:password] && creds[:tenant]
    end

    def get_endpoint_url(endpoints, region, interface)
      endpoint = endpoints.select { |ep| !ep[interface].empty? }
      raise CatalogError, "No endpoint available for region '#{region}' and interface '#{interface}'" unless endpoint
      endpoint[0][interface]
    end

    def setup(response)
      payload = JSON.load(response.body)
      @token   = payload["access"]["token"]["id"]
      @catalog = payload["access"]["serviceCatalog"]
      @expires = payload["access"]["token"]["expires"]
    end

    def scoped_credentials(creds)
      {
        "auth": {
          "passwordCredentials": {
            "username": creds[:user],
            "password": creds[:password]
          },
          "tenantName": creds[:tenant]
        }
      }
    end
  end
end
