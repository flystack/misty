require 'misty/auth'

module Misty
  class AuthV3 < Misty::Auth
    def self.path
      "/v3/auth/tokens"
    end

    def catalog_endpoints(endpoints, region, interface)
      endpoints.each do |endpoint|
        if endpoint["region_id"] == region && endpoint["interface"] == interface
          return endpoint["url"]
        end
      end
    end

    def credentials_valid?(creds)
      true if creds[:user] && creds[:password] && creds[:project]
    end

    def get_endpoint_url(endpoints, region, interface)
      endpoint = endpoints.select { |ep| ep["region_id"] == region && ep["interface"] == interface }
      raise CatalogError, "No endpoint available for region '#{region}' and interface '#{interface}'" unless endpoint
      endpoint[0]["url"]
    end

    def setup(response)
      payload = JSON.load(response.body)
      @token = response["x-subject-token"]
      @catalog = payload["token"]["catalog"]
      @expires = payload["token"]["expires_at"]
    end

    def scoped_credentials(creds)
      creds[:domain] ||= "default"
      creds[:user_domain] ||= creds[:domain]
      {
        "auth": {
          "identity": {
            "methods": ["password"],
            "password": {
              "user": {
                "name": creds[:user],
                "domain": { "id": creds[:user_domain] },
                "password": creds[:password]
              }
            }
          },
          "scope": {
            "project": {
              "name": creds[:project],
              "domain": { "id": creds[:domain] }
            }
          }
        }
      }
    end
  end
end
