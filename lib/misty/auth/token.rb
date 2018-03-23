require 'misty/http/net_http'
module Misty
  module Auth
    module Token
      include Misty::HTTP::NetHTTP
      attr_reader :catalog, :expires, :token, :user

      def self.build(auth)
        if auth[:tenant_id] || auth[:tenant]
          Misty::Auth::Token::V2.new(auth)
        else
          Misty::Auth::Token::V3.new(auth)
        end
      end

      def initialize(auth)
        @log = auth[:log]

        if auth[:context] && auth[:context][:token] && auth[:context][:expires] && auth[:context][:catalog]
          # Bypass authentication
          @catalog = Misty::Auth::Catalog.new(auth[:context][:catalog])
          @expires = auth[:context][:expires]
          @token = auth[:context][:token]
        else
          raise URLError, 'No URL provided' if auth[:url].nil? || auth[:url].empty?
          @creds = {
            :data            => set_credentials(auth),
            :ssl_verify_mode => auth[:ssl_verify_mode].nil? ? Misty::Config::SSL_VERIFY_MODE : auth[:ssl_verify_mode],
            :uri             => URI.parse(auth[:url])
          }
          set(authenticate(@creds))
        end
      end

      def get
        set(authenticate(@creds)) if expired?
        @token
      end

      private

      def authenticate(creds)
        Misty::HTTP::NetHTTP.http_request(
          creds[:uri], ssl_verify_mode: creds[:ssl_verify_mode], log: @log
        ) do |connection|
          response = connection.post(path, creds[:data].to_json,
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

      def refresh
        raise StandardError, "__method__ not implemented yet!"
      end
    end
  end
end
