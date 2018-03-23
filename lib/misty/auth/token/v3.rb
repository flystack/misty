require 'misty/auth/token'
require 'misty/auth/name'

module Misty
  module Auth
    module Token
      class V3
        include Misty::Auth::Token
        attr_reader :domain, :project

        # Default Domain ID
        DOMAIN_ID = 'default'

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
            @project = Misty::Auth::ProjectScope.new(auth[:project_id], auth[:project])

            if auth[:project_domain_id] || auth[:project_domain]
              @project.domain = Misty::Auth::Name.new(auth[:project_domain_id], auth[:project_domain])
            else
              if auth[:domain_id] || auth[:domain]
                @project.domain = Misty::Auth::Name.new(auth[:domain_id], auth[:domain])
              else
                @project.domain = Misty::Auth::Name.new(DOMAIN_ID, nil)
              end
            end
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
            @user.password = auth[:password]

            if auth[:user_domain_id] || auth[:user_domain]
              @user.domain = Misty::Auth::Name.new(auth[:user_domain_id], auth[:user_domain])
            else
              if auth[:domain_id] || auth[:domain]
                @user.domain = Misty::Auth::Name.new(auth[:domain_id], auth[:domain])
              else
                @user.domain = Misty::Auth::Name.new(DOMAIN_ID, nil)
              end
            end
          end

          credentials
        end
      end
    end
  end
end
