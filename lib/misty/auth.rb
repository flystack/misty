require 'logger'
require 'misty/auth/errors'
require 'misty/auth/name'
require 'misty/http/net_http'
require 'misty/config'

module Misty

  # The credentials are a combination of "id" and "name" used to uniquely identify the context.
  # +Misty::Auth+ is mixing the common interface between +Misty::AuthV3+ and +Misty::AuthV2+

  module Auth
    include Misty::HTTP::NetHTTP

    attr_reader :catalog, :token

    def self.build(auth)
      raise CredentialsError if auth.empty?
      version = auth[:tenant_id] || auth[:tenant] ? 'V2' : 'V3'
      klass = Object.const_get("Misty::Auth#{version}")
      klass.new(auth)
    end

    def initialize(auth)
      if auth[:context]
        # bypass the authentication by given token catalog and expire date
        @token   = auth[:context][:token]
        @catalog = auth[:context][:catalog]
        @expires = auth[:context][:expires]
      else
        raise URLError, 'No URL provided' if auth[:url].nil? || auth[:url].empty?
        @uri = URI.parse(auth[:url])
        @ssl_verify_mode = auth[:ssl_verify_mode] ? auth[:ssl_verify_mode] : Misty::Config::SSL_VERIFY_MODE
        @credentials = set_credentials(auth)
        @token, @catalog, @expires = set(authenticate)
        # TODO: Pass main log object
        @log = Logger.new('/dev/null')
      end
    end

    def authenticate
      Misty::HTTP::NetHTTP.http_request(
        @uri, ssl_verify_mode: @ssl_verify_mode, log: @log
      ) do |connection|
        response = connection.post(path, @credentials.to_json,
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
          if (url = endpoint_url(endpoint, region_id, interface))
            return url
          end
        end
      end
      message = "No endpoint found: service '#{service['type']}', region '#{region_id}', interface '#{interface}'"
      raise CatalogError, message
    end
  end
end
