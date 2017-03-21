require 'misty/auth'

module Misty
  class AuthV2 < Misty::Auth
    def self.path
      "/v2.0/tokens"
    end

    def initialize(options, *args)
      @user = Misty::Auth::User.new(options[:user_id], options[:user])
      @user.password = options[:password]
      @tenant = Misty::Auth::Name.new(options[:tenant_id], options[:tenant])
      super(options, *args)
    end

    def catalog_endpoints(endpoints, region, interface)
      endpoints.each do |endpoint|
        if endpoint["region"] == region && endpoint["#{interface}URL"]
          return endpoint["#{interface}URL"]
        end
      end
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

    def scoped_authentication
      raise Misty::Auth::CredentialsError, "#{self.class}: User name is required" if @user.name.nil?
      raise Misty::Auth::CredentialsError, "#{self.class}: User password is required" if @user.password.nil?
      return auth_by_id if @tenant.id
      return auth_by_name if @tenant.name
      raise Misty::Auth::CredentialsError, "#{self.class}: No tenant available"
    end

    def auth_by_name
      {
        "auth": {
          "passwordCredentials": credentials,
          "tenantName": @tenant.name
        }
      }
    end

    def auth_by_id
      {
        "auth": {
          "passwordCredentials": credentials,
          "tenantId": @tenant.id
        }
      }
    end

    def credentials
      {
        "username": @user.name,
        "password": @user.password
      }
    end
  end
end
