module Misty
  module HTTP
    # This class implements the http request routine.
    module NetHTTP
      def self.http_request(uri, options = {})
        verify_mode = if options[:ssl_verify_mode]
                        OpenSSL::SSL::VERIFY_PEER
                      else
                        OpenSSL::SSL::VERIFY_NONE
                      end
        Net::HTTP.start(
          uri.host, uri.port,
          use_ssl: (uri.scheme == 'https'),
          verify_mode: verify_mode
        ) do |connection|
          yield(connection)
        end
      end
    end
  end
end
