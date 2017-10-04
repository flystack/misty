require 'misty/http/net_http'
require 'misty/auth/name'

module Misty
  class Auth
    class AuthenticationError < StandardError; end
    class CatalogError        < StandardError; end
    class TokenError          < StandardError; end

    class ExpiryError      < RuntimeError; end
    class CredentialsError < RuntimeError; end
    class InitError        < RuntimeError; end
    class URLError         < RuntimeError; end

    include Misty::HTTP::NetHTTP

    attr_reader :catalog, :token

    def self.factory(auth, config)
      version = auth[:tenant_id] || auth[:tenant] ? 'V2' : 'V3'
      klass = Object.const_get("Misty::Auth#{version}")
      klass.new(auth, config)
    end

    def initialize(auth, config)
      if auth[:context]
        # bypass the authentication by given token catalog and expire date
        @token   = auth[:context][:token]
        @catalog = auth[:context][:catalog]
        @expires = auth[:context][:expires]
      else
        raise URLError, 'No URL provided' if auth[:url].nil? || auth[:url].empty?
        @uri = URI.parse(auth[:url])
        @config = config
        @credentials = set_credentials(auth)
        @token, @catalog, @expires = set(authenticate)
      end
    end

    def authenticate
      Misty::HTTP::NetHTTP.http_request(
        @uri, ssl_verify_mode: @config.ssl_verify_mode, log: @config.log
      ) do |connection|
        response = connection.post(self.class.path, @credentials.to_json,
          { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
        unless response.code =~ /200|201/
          raise AuthenticationError, "Response code=#{response.code}, Msg=#{response.msg}"
        end
        response
      end
    end

    def expired?
      if @expires.nil? || @expires.empty?
        raise ExpiryError, 'Missing token expiration data'
      end
      Time.parse(@expires) < Time.now.utc
    end

    def get_url(service_names, region_id, interface)
      find_url(get_service(service_names), region_id, interface)
    end

    def get_service(service_names)
      @catalog.each do |service|
        return service if service_names.include?(service['type'])
      end
      raise CatalogError, "No service '#{service_names}' found."
    end

    def get_token
      @token, @catalog, @expires = set(authenticate) if expired?
      @token
    end

    def find_url(service, region_id, interface)
      if service['endpoints']
        service['endpoints'].each do |endpoint|
          if (url = self.class.get_url(endpoint, region_id, interface))
            return url
          end
        end
      end
      message = "No endpoint found: service '#{service['type']}', region '#{region_id}', interface '#{interface}'"
      raise CatalogError, message
    end
  end
end
