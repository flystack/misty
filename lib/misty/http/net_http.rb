module Misty
  module HTTP
    module NetHTTP
      @net_http_mutex = Mutex.new

      def self.net_http(endpoint, options, log)
        @net_http_mutex.synchronize do
          http = Net::HTTP.new(endpoint.host, endpoint.port)
          http.set_debug_output(log) if log.level == Logger::DEBUG
          if endpoint.scheme == "https"
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless options[:ssl_verify_mode]
          end
          if options[:keep_alive_timeout] && options[:keep_alive_timeout].is_a?(Integer)
            http.keep_alive_timeout = options[:keep_alive_timeout]
          end
          http
        end
      end
    end
  end
end
