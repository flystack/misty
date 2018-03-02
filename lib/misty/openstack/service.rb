module Misty
  module Openstack
    module Service
      include Misty::Config

      attr_reader :headers, :microversion

      # ==== Attributes
      #
      # * +args+ - Hash of configuration parameters for authentication, log, and services options.
      #
      def initialize(args)
        @auth = args[:auth]
        @log = args[:log]

        # Service level parameters "locals"
        @interface = args[:interface]
        @content_type = args[:content_type]
        @region_id = args[:region_id]
        @ssl_verify_mode = args[:ssl_verify_mode]
        @headers = Misty::HTTP::Header.new(args[:headers].get.clone)
        @headers.add(microversion_header) if microversion

        @uri = URI.parse(@auth.get_url(service_names, @region_id, @interface))

        @base_path = args[:base_path] ? args[:base_path] : nil
        @base_url  = args[:base_url]  ? args[:base_url] : nil
        @init_version = args[:version] ? args[:version] : 'CURRENT'

        @base_path = @base_path ? @base_path : @uri.path
        @base_path = @base_path.chomp('/')
        @version = nil
        @microversion = false
      end

      # When a catalog provides a base path and the Service API definition containts the generic equivalent as prefix
      # then the preifx is redundant and must be removed from the path.
      #
      # To use Mixing classes must override
      #
      # For exampe, if a Catalog is defined with
      # 'http://192.0.2.21:8004/v1/48985e6b8da145699d411f12a3459fc'
      # and Service API resource has '/v1/{tenant_id}/stacks'
      # then the path prefix is ignored and path is only +/stacks+
      def prefix_path_to_ignore
        ''
      end

      # Generate available requests available for current service
      def requests
        requests_api + requests_custom
      end

      private

      def baseclass
        self.class.to_s.split('::')[-1]
      end

      def requests_api
        @requests_api_list ||= begin
          list = []
          api.each do |_path, verbs|
            verbs.each do |_verb, requests|
              list << requests
            end
          end
          list.flatten!
        end
      end

      def requests_custom
        []
      end
    end
  end
end
