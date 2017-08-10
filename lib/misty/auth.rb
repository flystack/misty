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
      http = nil
      unless auth[:context]
        raise URLError, "No URL provided" unless auth[:url] && !auth[:url].empty?
        connection_options = {
          ssl_verify_mode: config.ssl_verify_mode,
          keep_alive_timeout: config.keep_alive_timeout
        }
        http = Misty::HTTP::NetHTTP.net_http(URI.parse(auth[:url]), connection_options, config.log)
      end

      if auth[:tenant_id] || auth[:tenant]
        return Misty::AuthV2.new(auth, http)
      else
        return Misty::AuthV3.new(auth, http)
      end
    end

    def initialize(auth, http)
      if auth[:context]
        # bypass the authentication by given token catalog and expire date
        @token   = auth[:context][:token]
        @catalog = auth[:context][:catalog]
        @expires = auth[:context][:expires]
      else
        @http = http
        # autheticate
        @credentials = set_credentials(auth)
        @token, @catalog, @expires = set(authenticate)
      end
    end

    def authenticate
      @http.start do |connection|
        response = connection.post(self.class.path, @credentials.to_json, Misty::HEADER_JSON)
        raise AuthenticationError, "Response code=#{response.code}, Msg=#{response.msg}" unless response.code =~ /200|201/
        response
      end
    end

    def expired?
      raise ExpiryError, "Missing token expiration data" if @expires.nil? || @expires.empty?
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
