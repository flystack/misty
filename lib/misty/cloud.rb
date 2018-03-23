require 'misty/config'
require 'misty/http/header'

module Misty
  class Cloud
    attr_reader :config

    def self.dot_to_underscore(val)
      val.gsub(/\./,'_')
    end

    def initialize(arg)
      @config = Misty::Config.new(arg)
    end

    def build_service(method)
      service = Misty.services.find {|service| service.type == method}
      service_config = @config.get_service(method)
      api_version = self.class.dot_to_underscore(service.default_version(service_config[:config][:api_version]))
      klass = Object.const_get("Misty::Openstack::API::#{service.project.capitalize}::#{api_version.capitalize}")
      klass.new(service_config)
    end

    def application_catalog(arg = {})
      @application_catalog ||= build_service(__method__)
      @application_catalog.request_config(arg)
      @application_catalog
    end

    def alarming(arg = {})
      @alarming ||= build_service(__method__)
      @alarming.request_config(arg)
      @alarming
    end

    def backup(arg = {})
      @backup ||= build_service(__method__)
      @backup.request_config(arg)
      @backup
    end

    def baremetal(arg = {})
      @baremetal ||= build_service(__method__)
      @baremetal.request_config(arg)
      @baremetal
    end

    def block_storage(arg = {})
      @block_storage ||= build_service(__method__)
      @block_storage.request_config(arg)
      @block_storage
    end

    def clustering(arg = {})
      @clustering ||= build_service(__method__)
      @clustering.request_config(arg)
      @clustering
    end

    def compute(arg = {})
      @compute ||= build_service(__method__)
      @compute.request_config(arg)
      @compute
    end

    def container_infrastructure_management(arg = {})
      @container_infrastructure_management ||= build_service(__method__)
      @container_infrastructure_management.request_config(arg)
      @container_infrastructure_management
    end

    def container_service(arg = {})
      @container_service ||= build_service(__method__)
      @container_service.request_config(args)
      @container_service
    end

    def data_processing(arg = {})
      @data_processing ||= build_service(__method__)
      @data_processing.request_config(arg)
      @data_processing
    end

    def data_protection_orchestration(arg = {})
      @data_protection_orchestration ||= build_service(__method__)
      @data_protection_orchestration.request_config(arg)
      @data_protection_orchestration
    end

    def database(arg = {})
      @database ||= build_service(__method__)
      @database.request_config(arg)
      @database
    end

    def dns(arg = {})
      @dns ||= build_service(__method__)
      @dns.request_config(arg)
      @dns
    end

    def event(arg = {})
      @event ||= build_service(__method__)
      @event.request_config(args)
      @event
    end

    def identity(arg = {})
      @identity ||= build_service(__method__)
      @identity.request_config(arg)
      @identity
    end

    def image(arg = {})
      @image ||= build_service(__method__)
      @image.request_config(arg)
      @image
    end

    def instance_ha(arg = {})
      @instance_ha ||= build_service(__method__)
      @instance_ha.request_config(args)
      @instance_ha
    end

    def key_manager(arg = {})
      @key_manager ||= build_service(__method__)
      @key_manager.request_config(args)
      @key_manager
    end

    def load_balancer(arg = {})
      @load_balancer ||= build_service(__method__)
      @load_balancer.request_config(arg)
      @load_balancer
    end

    def messaging(arg = {})
      @messaging ||= build_service(__method__)
      @messaging.request_config(arg)
      @messaging
    end

    def metering(arg = {})
      @metering ||= build_service(__method__)
      @metering.request_config(arg)
      @metering
    end

    def metric(arg = {})
      @metric ||= build_service(__method__)
      @metric.request_config(args)
      @metric
    end

    def monitoring(arg = {})
      @monitoring ||= build_service(__method__)
      @monitoring.request_config(args)
      @monitoring
    end

    def network(arg = {})
      @network ||= build_service(__method__)
      @network.request_config(arg)
      @network
    end

    def nfv_orchestration(arg = {})
      @nfv_orchestration ||= build_service(__method__)
      @nfv_orchestration.request_config(arg)
      @nfv_orchestration
    end

    def object_storage(arg = {})
      @object_storage ||= build_service(__method__)
      @object_storage.request_config(arg)
      @object_storage
    end

    def orchestration(arg = {})
      @orchestration ||= build_service(__method__)
      @orchestration.request_config(arg)
      @orchestration
    end

    def placement(arg = {})
      @placement ||= build_service(__method__)
      @placement.request_config(args)
      @placement
    end

    def reservation(arg = {})
      @reservation ||= build_service(__method__)
      @reservation.request_config(args)
      @reservation
    end

    def resource_optimization(arg = {})
      @resource_optimization ||= build_service(__method__)
      @resource_optimization.request_config(args)
      @resource_optimization
    end

    def search(arg = {})
      @search ||= build_service(__method__)
      @search.request_config(arg)
      @search
    end

    def shared_file_systems(arg = {})
      @shared_file_systems ||= build_service(__method__)
      @shared_file_systems.request_config(arg)
      @shared_file_systems
    end

    def workflow(arg = {})
      @workflow ||= build_service(__method__)
      @workflow.request_config(args)
      @workflow
    end

    alias domain_name_server dns
    alias volume block_storage

    private

    def method_missing(method_name, arg = {})
      services_avail = []
      Misty.services.types.each do |serv|
        services_avail << serv if /^#{method_name}/.match(serv)
      end

      if services_avail.size == 1
        type = services_avail[0]
        raise NoMethodError, "No such Cloud Service: #{method_name}" unless self.class.method_defined?(type)
      elsif services_avail.size > 1
        raise NoMethodError, "Ambiguous Cloud Service: #{method_name}"
      else
        raise NoMethodError, "No such Cloud Service: #{method_name}"
      end

      send(type, arg)
    end
  end
end
