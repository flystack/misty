require 'misty/auth'

module Misty
  #
  # Openstack Identity service Keystone version 3 relies on the concept of domain name or id to authenticates
  # +Misty::AuthV3+ is used by default unless authentication credentials contains a tenant name or id in wich case it
  # will use on +Misty::AuthV2+.
  #
  # The credentials are a combination of "id" and "name" used to uniquely identify projects, users and their domains.
  # When using only the name, a domain must be specified to guarantee a unique record from the Identity service.
  #
  # ==== Attributes
  #
  # * +args+ - Hash of configuration parameters for authentication, log, and services options.
  # See +Misty::Config+ for details
  #
  # ==== Arguments
  #
  # The following parameters can be used:
  # To authenticate with credentials details:
  # * +:domain_id+ - Domain id, default: "default"
  # * +:domain+ - Domain name, default: "Default"
  # * +:project_id+ - Project id
  # * +:project+ - Project name
  # * +:project_domain_id+ - Project domain id
  # * +:project_domain+ - Project domain name
  # * +:user_id+ - User id
  # * +:user+ - User name
  # * +:user_domain_id+ - User domain id
  # * +:user_domain+ - User domain name
  # * +:password+ - User password. Exclusive with :token.
  # * +:ssl_verify_mode+ - Boolean flag for SSL client verification. SSL is defined when URI scheme => "https://".
  # * +:token+ - User provided token, overrides all user and password parameters.
  #
  # Or alternatively with a context:
  # * +:context+ - Allow to provide already authenticated context with service catalog, token and its expire date.
  #   Overrides all user and password parameters and assumes V3.
  #
  # ==== Examples
  #
  # Authenticate using credentials
  #   auth_v3 = {
  #     :url                => 'http://localhost:5000',
  #     :user               => 'admin',
  #     :password           => 'secret',
  #     :domain             => 'default',
  #     :project            => 'admin',
  #     :project_domain_id  => 'default'
  #   }
  #   cloud = Misty::Cloud.new(:auth => auth_v3)
  #
  # Or alternatively using a context
  #   context = {
  #     :context => { :token => token_id, :catalog => service_catalog, :expires => expire_date }
  #   }
  #  cloud = Misty::Cloud.new(:auth => context)
  #
  # Also, the API request set is specific to this version:
  #   cloud.identity.list_projects
  #
  #
  # ==== Note
  # It's possible to authenticate against Keystone V3 and use the identity service v2.0, for instance:
  # In which case API set for v2.0 applies: tenants are available but not the projects.
  #   cloud = Misty::Cloud.new(:auth => auth_v3)
  #   cloud.identity(:api_version => 'v2.0')
  #
  class AuthV3
    include Misty::Auth

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

    def endpoint_url(endpoint, region_id, interface)
      return endpoint['url'] if endpoint['region_id'] == region_id && endpoint['interface'] == interface
    end

    def path
      '/v3/auth/tokens'
    end

    def scope
      return @project.identity if @project
      return @domain.identity if @domain
      raise CredentialsError, "#{self.class}: No scope available"
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
