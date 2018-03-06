module Misty
  module Openstack
    module Service
      attr_reader :headers, :microversion

      # ==== Attributes
      #
      # * +arg+ - +Misty::Config+ instance
      #
      def initialize(arg)
        @auth = arg[:auth]
        @log = arg[:log]
        @config = arg[:config]

        @content_type = @config[:content_type]
        @headers = Misty::HTTP::Header.new(@config[:headers].get.clone)
        @headers.add(microversion_header) if microversion
        @ssl_verify_mode = @config[:ssl_verify_mode]

        @uri = URI.parse(@auth.get_url(service_names, @config[:region_id], @config[:interface]))

        @base_path = @config[:base_path] ? @config[:base_path] : @uri.path
        @base_path = @base_path.chomp('/')
        @base_url  = @config[:base_url]  ? @config[:base_url] : nil
        @init_version = @config[:version] ? @config[:version] : 'CURRENT'

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

      def set_ether_config(arg)
        @ether_content_type = arg[:content_type] if arg[:content_type]
        @ether_headers = HTTP::Header.new(arg[:headers]) if arg[:headers]
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
