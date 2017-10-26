require 'misty/auth/auth_v2'
require 'misty/auth/auth_v3'
require 'misty/http/header'

module Misty
  class Cloud
    class Config
      attr_accessor :auth, :content_type, :interface, :log, :region_id, :ssl_verify_mode, :headers
    end

    attr_reader :auth

    def self.dot_to_underscore(val)
      val.gsub(/\./,'_')
    end

    def initialize(params)
      @params = params
      @config = self.class.set_configuration(params)
      @auth = Misty::Auth.factory(params[:auth], @config)
    end

    def self.set_configuration(params)
      config = Config.new
      config.content_type = params[:content_type] ? params[:content_type] : Misty::CONTENT_TYPE
      config.interface = params[:interface] ? params[:interface] : Misty::INTERFACE
      config.log = Logger.new(params[:log_file] ? params[:log_file] : Misty::LOG_FILE)
      config.log.level = params[:log_level] ? params[:log_level] : Misty::LOG_LEVEL
      config.region_id = params[:region_id] ? params[:region_id] : Misty::REGION_ID
      config.ssl_verify_mode = params.key?(:ssl_verify_mode) ? params[:ssl_verify_mode] : Misty::SSL_VERIFY_MODE
      config.headers = Misty::HTTP::Header.new('Accept' => 'application/json; q=1.0')
      config.headers.add(params[:headers]) if params[:headers] && !params[:headers].empty?
      config
    end

    def build_service(service_name)
      service = Misty.services.find {|service| service.name == service_name}
      options = @params[service.name] ? @params[service.name] : {}
      version = self.class.dot_to_underscore(service.version(options[:api_version]))
      klass = Object.const_get("Misty::Openstack::#{service.project.capitalize}::#{version.capitalize}")
      klass.new(@auth, @config, options)
    end

    def application_catalog
      @application_catalog ||= build_service(:application_catalog)
    end

    def alarming
      @alarming ||= build_service(:alarming)
    end

    def backup
      @backup ||= build_service(:backup)
    end

    def baremetal
      @baremetal ||= build_service(:baremetal)
    end

    def block_storage
      @block_storage ||= build_service(:block_storage)
    end

    def clustering
      @clustering ||= build_service(:clustering)
    end

    def compute
      @compute ||= build_service(:compute)
    end

    def container_infrastructure_management
      @container_infrastructure_management ||= build_service(:container_infrastructure_management)
    end

    def data_processing
      @data_processing ||= build_service(:data_processing)
    end

    def data_protection_orchestration
      @data_protection_orchestration ||= build_service(:data_protection_orchestration)
    end

    def database
      @database ||= build_service(:database)
    end

    def domain_name_server
      @domain_name_server ||= build_service(:domain_name_server)
    end

    def identity
      @identity ||= build_service(:identity)
    end

    def image
      @image ||= build_service(:image)
    end

    def load_balancer
      @load_balancer ||= build_service(:load_balancer)
    end

    def messaging
      @messaging ||= build_service(:messaging)
    end

    def metering
      @metering ||= build_service(:metering)
    end

    def networking
      @networking ||= build_service(:networking)
    end

    def nfv_orchestration
      @nfv_orchestration ||= build_service(:nfv_orchestration)
    end

    def object_storage
      @object_storage ||= build_service(:object_storage)
    end

    def orchestration
      @orchestration ||= build_service(:orchestration)
    end

    def search
      @search ||= build_service(:search)
    end

    def shared_file_systems
      @shared_file_systems ||= build_service(:shared_file_systems)
    end

    alias dns domain_name_server
    alias volume block_storage

    private

    def method_missing(method_name)
      services_avail = []
      Misty.services.names.each do |service_name|
        services_avail << service_name if /#{method_name}/.match(service_name)
      end

      if services_avail.size == 1
        self.send(services_avail[0])
        return self.instance_variable_get("@#{services_avail[0]}")
      elsif services_avail.size > 1
        raise NoMethodError, "Ambiguous Cloud Service: #{method_name}"
      else
        raise NoMethodError, "No such Cloud Service: #{method_name}"
      end
    end
  end
end
