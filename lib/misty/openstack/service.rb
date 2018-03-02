module Misty
  module Openstack
    module Service
      include Misty::Config

      attr_reader :headers, :microversion
      # ==== Attributes
      #
      # * +args+ - Hash of configuration parameters for authentication, log, and services options.
      #
      # ==== Options
      #
      # The globals configuration variables are passed from +Misty::Cloud+.
      # They can be overriden for local needs at the service level.
      # On top of that, the following parameters can also be used:
      #
      # * +:base_path+ - Allows to force the base path for every URL requests
      # * +:base_url+ - Allows to force the base URL for every requests
      # * +:version+ - Version to be used when microversion is supported by the service.
      #     Allowed values: "CURRENT", "LATEST", "SUPPORTED", or a version number such as "2.0" or "3"
      #     Default: `"CURRENT"`
      #
      # ==== Examples
      #
      #   # Initialize cloud with globals
      #   #
      #   cloud = Misty::Cloud.new(:auth => { ... }, region_id => 'regionOne', :log_level => 0)
      #   # Use a different options for the identify service, therefore override global defaults or specified values
      #   cloud.identity => {:region_id => 'regionTwo', :interface => 'admin'}
      #   # Provide service specific option
      #   cloud.compute  => {:version => '2.27'})

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

      # Provides requests available for current service
      #
      # ==== Example
      #
      #  # Output truncated
      #  cloud.compute.requests
      #  => [:add_a_single_tag,
      #   :add_associate_fixed_ip_addfixedip_action_deprecated,
      #   :add_associate_floating_ip_addfloatingip_action_deprecated,
      #   :add_flavor_access_to_tenant_addtenantaccess_action,
      #   :add_host,
      #   :add_network,
      #   :add_security_group_to_a_server_addsecuritygroup_action,
      #   :associate_host_deprecated,
      #   :attach_a_volume_to_an_instance,
      #   :bulk_delete_floating_ips,
      #   :capacities,
      #   :change_administrative_password_changepassword_action,
      #   :check_tag_existence,
      #   :clear_admin_password,
      #   :confirm_resized_server_confirmresize_action,
      #   :create_agent_build,
      #   :create_aggregate,
      #   :create_allocate_floating_ip_address,
      #   :create_assisted_volume_snapshots,
      #   :create_cell,
      #   :create_cloudpipe,
      #   :create_console]

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
