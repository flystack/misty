require 'misty/auth'

module Misty
  class AuthV2 < Misty::Auth
    def self.path
      '/v2.0/tokens'
    end

    def catalog_endpoints(endpoints, region, interface)
      endpoints.each do |endpoint|
        if endpoint['region'] == region && endpoint["#{interface}URL"]
          return endpoint["#{interface}URL"]
        end
      end
    end

    def credentials
      if @token
        identity = { 'token': { 'id': @token } }
      else
        raise Misty::Auth::CredentialsError, "#{self.class}: User name is required" if @user.name.nil?
        raise Misty::Auth::CredentialsError, "#{self.class}: User password is required" if @user.password.nil?
        identity = { 'passwordCredentials': user_credentials }
      end

      if @tenant.id
        identity.merge!('tenantId': @tenant.id)
      elsif @tenant.name
        identity.merge!('tenantName': @tenant.name)
      else
        raise Misty::Auth::CredentialsError, "#{self.class}: No tenant available"
      end

      { 'auth': identity }
    end

    def user_credentials
      {
        'username': @user.name,
        'password': @user.password
      }
    end

    def get_endpoint_url(endpoints, region, interface)
      endpoint = endpoints.select { |ep| !ep[interface].empty? }
      raise CatalogError, "No endpoint available for region '#{region}' and interface '#{interface}'" unless endpoint
      endpoint[0][interface]
    end

    def set(response)
      payload = JSON.load(response.body)
      token   = payload['access']['token']['id']
      catalog = payload['access']['serviceCatalog']
      expires = payload['access']['token']['expires']
      [token, catalog, expires]
    end

    def set_credentials(auth)
      if auth[:token]
        @token = auth[:token]
      else
        @user = Misty::Auth::User.new(auth[:user_id], auth[:user])
        @user.password = auth[:password]
      end

      @tenant = Misty::Auth::Name.new(auth[:tenant_id], auth[:tenant])
      credentials
    end
  end
end
