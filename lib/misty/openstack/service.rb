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
        @ssl_verify_mode = @config[:ssl_verify_mode]

        @uri = URI.parse(@auth.get_url(service_types, @config[:region_id], @config[:interface]))

        @base_path = @config[:base_path] ? @config[:base_path] : @uri.path
        @base_path = @base_path.chomp('/')
        @base_url  = @config[:base_url]  ? @config[:base_url] : nil

        if microversion
          asked_version = @config[:version] ? @config[:version] : ''
          @version = set_version(asked_version)
        end
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

      # Each option is recreated to bear new value or the one propagated from defaults, globals or service levels
      def request_config(arg = {})
        @request_content_type = arg[:content_type] ? arg[:content_type] : @content_type
        @request_headers = Misty::HTTP::Header.new(@headers.get.clone)
        @request_headers.add(arg[:headers]) if arg[:headers]
        if microversion
          request_version = if arg[:version]
                               set_version(arg[:version])
                             else
                               @version
                             end
          @request_headers.add(microversion_header(request_version)) if request_version
        end
      end

      # TODO: remove
      def baseclass
        self.class.to_s.split('::')[-1]
      end

      private

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
