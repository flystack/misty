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
          if scope
            {
              'auth': {
                'identity': identity,
                'scope': scope
              }
            }
          else
            { 'auth': { 'identity': identity } }
          end
        end

        def path
          '/v3/auth/tokens'
        end

        def scope
          return @project.identity if @project
          return @domain.identity if @domain
        end

        def set(response)
          @data = JSON.load(response.body)
          @token = response['x-subject-token']
          @expires = @data['token']['expires_at']
          catalog = @data['token']['catalog']
          if catalog
            @catalog = Misty::Auth::Catalog::V3.new(catalog)
          end
        end

        def set_credentials(auth)
          if auth[:project_id] || auth[:project]
            # project scoped
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
          elsif auth[:domain_id] || auth[:domain]
              # domain scoped
              @domain = Misty::Auth::DomainScope.new(auth[:domain_id], auth[:domain])
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
