require 'misty/auth'

module Misty
  #
  # Openstack Identity service Keystone version 2.0, which is deprecated, uses a tenant name or id to authenticates
  # +Misty::AuthV2+ is used if the authentication credentials contains a tenant name or id.
  #
  # ==== Attributes
  #
  # The following credentials parameters can be used:
  # * +:tenant_id+ - Tenant id, used only for Keystone v2.0 only
  # * +:tenant+ - Tenant name, used only for Keystone v2.0  only
  # * +:user_id+ - User id
  # * +:user+ - User name
  # * +:password+ - User password. Exclusive with :token.
  # * +:ssl_verify_mode+ - Boolean flag for SSL client verification. SSL is defined when URI scheme => "https://".
  # * +:token+ - User provided token, overrides all user and password parameters.
  #
  # ==== Example
  #    auth_v2 = {
  #      :url      => 'http://localhost:5000',
  #      :user     => 'admin',
  #      :password => 'secret',
  #      :tenant   => 'admin',
  #    }
  #    cloud = Misty::Cloud.new(:auth => auth_v2)
  #
  # Also, the API request set is specific to this version:
  #   cloud.identity.list_tenants
  #
  class AuthV2
    include Misty::Auth

    def credentials
      if @token
        identity = { 'token': { 'id': @token } }
      else
        raise CredentialsError, "#{self.class}: User name is required" if @user.name.nil?
        raise CredentialsError, "#{self.class}: User password is required" if @user.password.nil?
        identity = { 'passwordCredentials': user_credentials }
      end

      if @tenant.id
        identity.merge!('tenantId': @tenant.id)
      elsif @tenant.name
        identity.merge!('tenantName': @tenant.name)
      else
        raise CredentialsError, "#{self.class}: No tenant available"
      end

      { 'auth': identity }
    end

    def endpoint_url(endpoint, region_id, interface)
      return endpoint["#{interface}URL"] if endpoint['region'] == region_id && endpoint["#{interface}URL"]
    end

    def path
      '/v2.0/tokens'
    end

    def user_credentials
      {
        'username': @user.name,
        'password': @user.password
      }
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
