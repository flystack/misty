module Misty
  module Openstack
    module Service
      attr_reader :headers, :microversion

      def initialize(arg)
        @token = arg[:token]
        @log = arg[:log]
        @config = arg[:config]

        @content_type = @config[:content_type]
        @headers = Misty::HTTP::Header.new(@config[:headers].get.clone)
        @ssl_verify_mode = @config[:ssl_verify_mode]

        @endpoint = if @config[:endpoint]
                      URI.parse(@config[:endpoint])
                    else
                      names = service_types
                      names << @config[:service_name] if @config[:service_name]
                      URI.parse(@token.catalog.get_endpoint_url(names, @config[:interface], @config[:region]))
                    end

        @base_path = @config[:base_path] ? @config[:base_path] : @endpoint.path.chomp('/')

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

      # Each option is recreated for a request brief life duration to account for a new value if provided or use value
      # propagated from defaults, globals or service levels
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

      def service_types_soon
        project = self.class.to_s.split('::')[-2].downcase.to_sym
        s = Misty.services.find {|service| service.project == project}
        raise RuntimeError, 'No service types found' unless s&.name
        s.microversion
      end
    end
  end
end
