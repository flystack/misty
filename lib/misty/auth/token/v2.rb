require 'misty/auth/token'
require 'misty/auth/name'

module Misty
  module Auth
    module Token
      class V2
        include Misty::Auth::Token

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
          @token   = payload['access']['token']['id']
          @expires = payload['access']['token']['expires']
          catalog = payload['access']['serviceCatalog']
          @catalog = Misty::Auth::Catalog::V2.new(catalog)
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
  end
end
