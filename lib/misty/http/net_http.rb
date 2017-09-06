module Misty
  module HTTP
    # This class implements the http request routine.
    module NetHTTP
      def self.http_request(uri, options = {})
        http_options = {}
        if uri.scheme == 'https'
          http_options[:use_ssl] = true
          if options[:ssl_verify_mode] && options[:ssl_verify_mode] == false
            http_options[:verify_mode] = OpenSSL::SSL::VERIFY_NONE
          end
        end

        Net::HTTP.start(uri.host, uri.port, :ENV, http_options) do |connection|
          yield(connection)
        end
      end
    end
  end
end
