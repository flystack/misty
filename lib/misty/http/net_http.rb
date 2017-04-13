module Misty
  module HTTP
    module NetHTTP
      def net_http(endpoint, proxy, ssl_verify_mode, log)
        http = Net::HTTP.new(endpoint.host, endpoint.port, proxy.host, proxy.port, proxy.user, proxy.password)
        http.set_debug_output(log) if log.level == Logger::DEBUG
        if endpoint.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless ssl_verify_mode
        end
        http
      end
    end
  end
end
