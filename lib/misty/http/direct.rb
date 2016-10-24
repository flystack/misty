module Misty
  module HTTP
    # Provides methods to submit the current service with a path and override @base_path if needed
    module Direct
      def base_set(base_path)
        base = base_path ? base_path : @base_path
      end

      def delete(path, base_path = nil)
        http_delete(base_set(base_path) + path, headers)
      end

      def get(path, base_path = nil)
        http_get(base_set(base_path) + path, headers)
      end

      def post(path, data, base_path = nil)
        http_post(base_set(base_path) + path, headers, data)
      end

      def put(path, data, base_path = nil)
        http_put(base_set(base_path) + path, headers, data)
      end
    end
  end
end
