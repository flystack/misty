require 'misty/auth'

module Misty
  class AuthV3 < Misty::Auth
    def initialize(options, *args)
      if options[:project_id] || options[:project]
        # scope: project
        project_domain_id = options[:project_domain_id] ? options[:project_domain_id] : Misty::DOMAIN_ID
        @project = Misty::Auth::ProjectScope.new(options[:project_id], options[:project])
        @project.domain = Misty::Auth::Name.new(project_domain_id, options[:user_domain])
      else
        # scope: domain
        domain_id = options[:domain_id] ? options[:domain_id] : Misty::DOMAIN_ID
        @domain = Misty::Auth::DomainScope.new(domain_id, options[:domain]) if domain_id || options[:domain]
      end

      user_domain_id = options[:user_domain_id] ? options[:user_domain_id] : Misty::DOMAIN_ID
      @user =  Misty::Auth::User.new(options[:user_id], options[:user])
      @user.password = options[:password]
      @user.domain = Misty::Auth::Name.new(user_domain_id, options[:user_domain])

      super(options, *args)
    end

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

    def get_endpoint_url(endpoints, region, interface)
      endpoint = endpoints.select { |ep| ep["region_id"] == region && ep["interface"] == interface }
      raise CatalogError, "No endpoint available for region '#{region}' and interface '#{interface}'" unless endpoint
      endpoint[0]["url"]
    end

    def scoped_authentication
      {
        "auth": {
          "identity": {
            "methods": ["password"],
            "password":  @user.identity
          },
          "scope": scope
        }
      }
    end

    def scope
      return @project.identity if @project
      return @domain.identity if @domain
      raise Misty::Auth::CredentialsError, "#{self.class}: No scope available"
    end

    def setup(response)
      payload = JSON.load(response.body)
      @token = response["x-subject-token"]
      @catalog = payload["token"]["catalog"]
      @expires = payload["token"]["expires_at"]
    end
  end
end
