require 'misty/http/net_http'
require 'misty/http/method_builder'
require 'misty/http/request'
require 'misty/http/direct'

module Misty
  module HTTP
    class Client
      class InvalidDataError < StandardError; end

      include Misty::HTTP::NetHTTP
      include Misty::HTTP::MethodBuilder
      include Misty::HTTP::Request
      include Misty::HTTP::Direct

      INTERFACES = %w{admin public internal}

      attr_reader :microversion

      Options = Struct.new(:base_path, :base_url, :interface, :region_id, :service_names, :ssl_verify_mode, :version)

      def requests
        list = []
        self.class.api.each do |_path, verbs|
          verbs.each do |_verb, requests|
            list << requests
          end
        end
        list.flatten.sort
      end

      # Options - Values shown are the default
      #   Base path can be forced (Not recommended, mainly used for test purposes)
      #    :base_path => nil
      #   URL can be forced (Helps when setup is broken)
      #    :base_url => nil
      #   Endpoint type (admin, public or internal)
      #     :interface => "public"
      #   Region ID
      #    :region_id => "regionOne"
      #   Service name
      #    The Service names are pre defined but more can be added using this option.
      #    :service_name
      #   SSL Verify Mode
      #     :ssl_verify_mode => true
      #   (micro)version: Can be numbered (3.1) or by state (CURRENT, LATEST or SUPPORTED)
      #     :version => "CURRENT"
      def initialize(auth, config, options)
        @auth = auth
        @config = config
        @options = setup(options)
        @uri = URI.parse(@auth.get_endpoint(@options.service_names, @options.region_id, @options.interface))
        @base_path = @options.base_path ? @options.base_path : @uri.path
        @base_path = @base_path.chomp("/")
        @http = net_http(@uri, @config.proxy, @options[:ssl_verify_mode], @config.log)
        @version = nil
        @microversion = false
      end

      # Sub classes to override
      # When a catalog provides a base path and the Service API definition containts the generic equivalent as prefix
      # then the preifx is redundant and must be removed from the path.
      # For example:
      # Catalog provides "http://192.0.2.21:8004/v1/48985e6b8da145699d411f12a3459fca"
      # and Service API has "/v1/{tenant_id}/stacks"
      # then the path prefix is ignored and path is only "/stacks"
      def self.prefix_path_to_ignore
        ""
      end

      def headers_default
        Misty::HEADER_JSON
      end

      def headers
        h = headers_default.merge("X-Auth-Token" => "#{@auth.get_token}")
        h.merge!(microversion_header) if microversion
        h
      end

      private

      def baseclass
        self.class.to_s.split('::')[-1]
      end

      def setup(params)
        options = Options.new()
        options.base_path       = params[:base_path]       ? params[:base_path] : nil
        options.base_url        = params[:base_url]        ? params[:base_url] : nil
        options.interface       = params[:interface]       ? params[:interface] : @config.interface
        options.region_id       = params[:region_id]       ? params[:region_id] : @config.region_id
        options.service_names   = params[:service_name]    ? self.class.service_names << params[:service_name] : self.class.service_names
        options.ssl_verify_mode = params[:ssl_verify_mode] ? params[:ssl_verify_mode] : @config.ssl_verify_mode
        options.version         = params[:version]         ? params[:version] : "CURRENT"

        unless INTERFACES.include?(options.interface)
          raise InvalidDataError, "Options ':interface' must be one of #{INTERFACES}"
        end

        unless options.ssl_verify_mode == !!options.ssl_verify_mode
          raise InvalidDataError, "Options ':ssl_verify_mode' must be a boolean"
        end
        options
      end
    end
  end
end
