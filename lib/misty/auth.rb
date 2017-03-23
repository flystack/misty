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

    def self.factory(options, *args)
      if options[:tenant_id] || options[:tenant]
        return Misty::AuthV2.new(options, *args)
      else
        return Misty::AuthV3.new(options, *args)
      end
    end

    attr_reader :catalog

    def initialize(options, ssl_verify_mode, log)
      @ssl_verify_mode, @log =  ssl_verify_mode, log
      @credentials = scoped_authentication

      raise URLError, "No URL provided" unless options[:url] && !options[:url].empty?
      @uri = URI.parse(options[:url])
      @token = nil
      setup(authenticate)
      raise CatalogError, "No catalog provided during authentication" if @catalog.empty?
    end

    def authenticate
      http = net_http(@uri, @ssl_verify_mode, @log)
      response = http.post(self.class.path, @credentials.to_json, Misty::HEADER_JSON)
      raise AuthenticationError, "Response code=#{response.code}, Msg=#{response.msg}" unless response.code =~ /200|201/
      response
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
      authenticate if expired?
      @token
    end
  end
end
