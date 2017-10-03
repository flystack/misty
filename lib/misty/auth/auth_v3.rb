require 'misty/auth'

module Misty
  class AuthV3 < Misty::Auth
    def self.path
      '/v3/auth/tokens'
    end

    def self.get_url(endpoint, region_id, interface)
      return endpoint['url'] if endpoint['region_id'] == region_id && endpoint['interface'] == interface
    end

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

    def scope
      return @project.identity if @project
      return @domain.identity if @domain
      raise Misty::Auth::CredentialsError, "#{self.class}: No scope available"
    end

    def set(response)
      payload = JSON.load(response.body)
      token = response['x-subject-token']
      catalog = payload['token']['catalog']
      expires = payload['token']['expires_at']
      [token, catalog, expires]
    end

    def set_credentials(auth)
      if auth[:project_id] || auth[:project]
        # scope: project
        project_domain_id = auth[:project_domain_id]
        if project_domain_id.nil? && auth[:project_domain].nil?
          project_domain_id = Misty::DOMAIN_ID
        end

        @project = Misty::Auth::ProjectScope.new(auth[:project_id], auth[:project])
        @project.domain = Misty::Auth::Name.new(project_domain_id, auth[:project_domain])
      else
        # scope: domain
        if auth[:domain_id] || auth[:domain]
          @domain = Misty::Auth::DomainScope.new(auth[:domain_id], auth[:domain])
        else
          # Use default Domain
          @domain = Misty::Auth::DomainScope.new(Misty::DOMAIN_ID, nil)
        end
      end

      if auth[:token]
        @token = auth[:token]
      else
        user_domain_id = auth[:user_domain_id] ? auth[:user_domain_id] : Misty::DOMAIN_ID
        @user = Misty::Auth::User.new(auth[:user_id], auth[:user])
        @user.password = auth[:password]
        @user.domain = Misty::Auth::Name.new(user_domain_id, auth[:user_domain])
      end

      credentials
    end
  end
end
