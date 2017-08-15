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
        # autheticate
        @credentials = set_credentials(auth)
        @token, @catalog, @expires = set(authenticate)
      end
      #byebug unless config.is_a?(Misty::Cloud::Config)
    end

    def authenticate
      Misty::HTTP::NetHTTP.http_request(
        @uri, ssl_verify_mode: @config.ssl_verify_mode, log: @config.log
      ) do |connection|
        response = connection.post(self.class.path, @credentials.to_json,
                                   Misty::HEADER_JSON)
        unless response.code =~ /200|201/
          raise AuthenticationError,
                "Response code=#{response.code}, Msg=#{response.msg}"
        end
        response
      end
    end

    def expired?
      if @expires.nil? || @expires.empty?
        raise ExpiryError, "Missing token expiration data"
      end
      Time.parse(@expires) < Time.now.utc
    end

    def get_endpoint(service_names, region, interface)
      @catalog.each do |catalog|
        if service_names.include? catalog["type"]
          return catalog_endpoints(catalog["endpoints"], region, interface)
        end
      end
      raise CatalogError, "No service found with either #{service_names} name, region #{region}, interface #{interface}"
    end

    def get_token
      @token, @catalog, @expires = set(authenticate) if expired?
      @token
    end
  end
end
