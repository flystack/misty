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

    def initialize(args)
      @config = self.class.set_configuration(args)
      @auth = Misty::Auth.factory(args[:auth], @config)
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

    def build_service(args)
      service = Misty.services.find {|service| service.name == args[:service]}
      args.delete(:service)
      version = self.class.dot_to_underscore(service.version(args[:api_version]))
      klass = Object.const_get("Misty::Openstack::#{service.project.capitalize}::#{version.capitalize}")
      klass.new(@auth, @config, args)
    end

    def application_catalog(args = {})
      args[:service] = :application_catalog
      @application_catalog ||= build_service(args)
    end

    def alarming(args = {})
      args[:service] = :alarming
      @alarming ||= build_service(args)
    end

    def backup(args = {})
      args[:service] = :backup
      @backup ||= build_service(args)
    end

    def baremetal(args = {})
      args[:service] = :baremetal
      @baremetal ||= build_service(args)
    end

    def block_storage(args = {})
      args[:service] = :block_storage
      @block_storage ||= build_service(args)
    end

    def clustering(args = {})
      args[:service] = :clustering
      @clustering ||= build_service(args)
    end

    def compute(args = {})
      args[:service] = :compute
      @compute ||= build_service(args)
    end

    def container_infrastructure_management(args = {})
      args[:service] = :container_infrastructure_management
      @container_infrastructure_management ||= build_service(args)
    end

    def data_processing(args = {})
      args[:service] = :data_processing
      @data_processing ||= build_service(args)
    end

    def data_protection_orchestration(args = {})
      args[:service] = :data_protection_orchestration
      @data_protection_orchestration ||= build_service(args)
    end

    def database(args = {})
      args[:service] = :database
      @database ||= build_service(args)
    end

    def dns(args = {})
      args[:service] = :dns
      @dns ||= build_service(args)
    end

    def identity(args = {})
      args[:service] = :identity
      @identity ||= build_service(args)
    end

    def image(args = {})
      args[:service] = :image
      @image ||= build_service(args)
    end

    def load_balancer(args = {})
      args[:service] = :load_balancer
      @load_balancer ||= build_service(args)
    end

    def messaging(args = {})
      args[:service] = :messaging
      @messaging ||= build_service(args)
    end

    def metering(args = {})
      args[:service] = :metering
      @metering ||= build_service(args)
    end

    def networking(args = {})
      args[:service] = :networking
      @networking ||= build_service(args)
    end

    def nfv_orchestration(args = {})
      args[:service] = :nfv_orchestration
      @nfv_orchestration ||= build_service(args)
    end

    def object_storage(args = {})
      args[:service] = :object_storage
      @object_storage ||= build_service(args)
    end

    def orchestration(args = {})
      args[:service] = :orchestration
      @orchestration ||= build_service(args)
    end

    def search(args = {})
      args[:service] = :search
      @search ||= build_service(args)
    end

    def shared_file_systems(args = {})
      args[:service] = :shared_file_systems
      @shared_file_systems ||= build_service(args)
    end

    alias domain_name_server dns
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
