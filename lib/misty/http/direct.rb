module Misty
  module HTTP
    # Allows to submit http request wwith provided path and override base_path if needed
    module Direct

      # ==== Examples
      #    auth = { ... }
      #    cloud = Misty::Cloud.new(:auth => auth)
      #
      #    net = cloud.network.get('/v2.0/networks')
      #    pp net.body
      #
      #    id = cloud.identity.get('/')
      #    pp id.body
      #
      #    servers = cloud.compute.get('/servers')
      #    pp servers.body
      #
      #    img = cloud.image.get('/v1')
      #    pp img.body

      def base_set(base_path)
        base = base_path ? base_path : @base_path
      end

      def delete(path, base_path = nil)
        http_delete(base_set(base_path) + path, @headers.get)
      end

      def get(path, base_path = nil)
        http_get(base_set(base_path) + path, @headers.get)
      end

      def post(path, data, base_path = nil)
        http_post(base_set(base_path) + path, @headers.get, data)
      end

      def put(path, data, base_path = nil)
        http_put(base_set(base_path) + path, @headers.get, data)
      end
    end
  end
end
