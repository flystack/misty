module Misty
  module HTTP
    module Request
      def decode?(response)
        if @config.content_type != :json && response.code =~ /2??/  && !response.is_a?(Net::HTTPNoContent) \
          && !response.is_a?(Net::HTTPResetContent) && response.header["content-type"] \
          && response.header["content-type"].include?("application/json")
          true
        end
      end

      def http(request)
        @http.start do |connection|
          response = connection.request(request)
          response.body = JSON.load(response.body) if decode?(response)
          response
        end
      end

      def http_delete(path, headers)
        @config.log.info(http_to_s(path, headers))
        request = Net::HTTP::Delete.new(path, headers)
        http(request)
      end

      def http_copy(path, headers)
        @config.log.info(http_to_s(path, headers))
        request = Net::HTTP::Copy.new(path, headers)
        http(request)
      end

      def http_get(path, headers)
        @config.log.info(http_to_s(path, headers))
        request = Net::HTTP::Get.new(path, headers)
        http(request)
      end

      def http_head(path, headers)
        @config.log.info(http_to_s(path, headers))
        request = Net::HTTP::Head.new(path, headers)
        http(request)
      end

      def http_options(path, headers)
        @config.log.info(http_to_s(path, headers))
        request = Net::HTTP::Options.new(path, headers)
        http(request)
      end

      def http_patch(path, headers, data)
        @config.log.info(http_to_s(path, headers, data))
        request = Net::HTTP::Patch.new(path, headers)
        request.body = Misty.to_json(data)
        http(request)
      end

      def http_post(path, headers, data)
        @config.log.info(http_to_s(path, headers, data))
        request = Net::HTTP::Post.new(path, headers)
        request.body = Misty.to_json(data)
        http(request)
      end

      def http_put(path, headers, data)
        @config.log.info(http_to_s(path, headers, data))
        request = Net::HTTP::Put.new(path, headers)
        request.body = Misty.to_json(data)
        http(request)
      end

      def http_to_s(path, headers, data = nil)
        log = "base_url='#{@uri.host}:#{@uri.port}', path='#{path}', header=#{headers}"
        log << ", data='#{data}'" if data
      end
    end
  end
end
