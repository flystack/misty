module Misty
  module HTTP
    module NetHTTP
      def net_http(uri, ssl_verify_mode, log)
        http = Net::HTTP.new(uri.host, uri.port)
        if ENV['http_proxy']
          proxy_uri = URI.parse(ENV['http_proxy']) 
          http = Net::HTTP.new(uri.host, uri.port, proxy_uri.host, proxy_uri.port)
        end
        http.set_debug_output(log) if log.level == Logger::DEBUG
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless ssl_verify_mode
        end
        http
      end
    end
  end
end