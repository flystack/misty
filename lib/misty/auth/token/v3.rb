require 'misty/auth/token'
require 'misty/auth/name'

module Misty
  module Auth
    module Token
      class V3
        include Misty::Auth::Token

        def credentials
          if @token
            identity = {
              'methods': ['token'],
              'token': { 'id': @token }
            }
          else
            identity = {
              'methods': ['password'],
              'password': @user.identity
            }
          end
          {
            'auth': {
              'identity': identity,
              'scope': scope
            }
          }
        end

        def path
          '/v3/auth/tokens'
        end

        def scope
          return @project.identity if @project
          return @domain.identity if @domain
          raise DomainScopeError, "#{self.class}: No scope available"
        end

        def set(response)
          payload = JSON.load(response.body)
          @token = response['x-subject-token']
          @expires = payload['token']['expires_at']
          catalog = payload['token']['catalog']
          @catalog = Misty::Auth::Catalog::V3.new(catalog)
        end

        def set_credentials(auth)
          if auth[:project_id] || auth[:project]
            if auth[:project_domain_id].nil? && auth[:project_domain].nil?
              project_domain_id = DOMAIN_ID
            else
              project_domain_id = auth[:project_domain_id] if auth[:project_domain_id]
              project_domain = auth[:project_domain] if auth[:project_domain]
            end

            @project = Misty::Auth::ProjectScope.new(auth[:project_id], auth[:project])
            @project.domain = Misty::Auth::Name.new(project_domain_id, auth[:project_domain])
          else
            # scope: domain
            if auth[:domain_id] || auth[:domain]
              @domain = Misty::Auth::DomainScope.new(auth[:domain_id], auth[:domain])
            else
              # Use default Domain
              @domain = Misty::Auth::DomainScope.new(DOMAIN_ID, nil)
            end
          end

          if auth[:token]
            @token = auth[:token]
          else
            @user = Misty::Auth::User.new(auth[:user_id], auth[:user])

            if auth[:user_domain_id].nil? && auth[:user_domain].nil?
              user_domain_id = DOMAIN_ID
            else
              user_domain_id = auth[:user_domain_id] if auth[:user_domain_id]
              user_domain = auth[:user_domain] if auth[:user_domain]
            end

            @user.domain = Misty::Auth::Name.new(user_domain_id, user_domain)
            @user.password = auth[:password]
          end

          credentials
        end
      end
    end
  end
end
