module Misty
  module HTTP
    module Request

      DECODE_TO_JSON = ["application/json", "application/octet-stream"].freeze

      def decode?(response)
        return false if response.body.nil? || response.body.empty?
        if @request_content_type != :json && response.code =~ /2??/ \
          && !response.is_a?(Net::HTTPNoContent) \
          && !response.is_a?(Net::HTTPResetContent) \
          && response.header['content-type'] && decode_to_json?(response.header['content-type'])
          return true
        end
        false
      end

      def decode_to_json?(content_type)
        DECODE_TO_JSON.each do |type|
          return true if content_type.include?(type)
        end
        false
      end

      def http(request)
        request['X-Auth-Token'] = @token.get

        Misty::HTTP::NetHTTP.http_request(
          @endpoint, ssl_verify_mode: @ssl_verify_mode, log: @log
        ) do |connection|
          response = connection.request(request)
          response.body = JSON.parse(response.body) if decode?(response)
          response
        end
      end

      def http_delete(path, headers)
        @log.info(http_to_s('DELETE', path, headers))
        request = Net::HTTP::Delete.new(path, headers)
        http(request)
      end

      def http_copy(path, headers)
        @log.info(http_to_s('COPY', path, headers))
        request = Net::HTTP::Copy.new(path, headers)
        http(request)
      end

      def http_get(path, headers)
        @log.info(http_to_s('GET', path, headers))
        request = Net::HTTP::Get.new(path, headers)
        http(request)
      end

      def http_head(path, headers)
        @log.info(http_to_s('HEAD', path, headers))
        request = Net::HTTP::Head.new(path, headers)
        http(request)
      end

      def http_options(path, headers)
        @log.info(http_to_s('OPTIONS', path, headers))
        request = Net::HTTP::Options.new(path, headers)
        http(request)
      end

      def http_patch(path, headers, data)
        @log.info(http_to_s('PATCH', path, headers, data))
        request = Net::HTTP::Patch.new(path, headers)
        request.body = data
        http(request)
      end

      def http_post(path, headers, data)
        @log.info(http_to_s('POST', path, headers, data))
        request = Net::HTTP::Post.new(path, headers)
        request.body = data
        http(request)
      end

      def http_put(path, headers, data)
        @log.info(http_to_s('PUT', path, headers, data))
        request = Net::HTTP::Put.new(path, headers)
        request.body = data
        http(request)
      end

      def http_to_s(verb, path, headers, data = nil)
        log = "HTTP #{verb} '#{@endpoint.host}:#{@endpoint.port}/#{path}', header=#{headers}"
        log << ", data='#{data}'" if data
        log
      end
    end
  end
end
