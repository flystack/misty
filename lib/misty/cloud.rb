require 'misty/config'
require 'misty/http/header'

module Misty

  # +Misty::Cloud+ is the main OpenStack cloud class.
  # An instance holds authentication information such as token, catalog and contains all available services as methods.
  #
  class Cloud
    def self.dot_to_underscore(val)
      val.gsub(/\./,'_')
    end

    # ==== Attributes
    #
    # * +arg+ - Hash of configuration parameters for authentication, log, and services options.
    #
    def initialize(arg)
      @config = Misty::Config.new(arg)
    end

    def build_service(method)
      service = Misty.services.find {|service| service.name == method}
      service_config = @config.get_service(method)
      api_version = self.class.dot_to_underscore(service.default_version(service_config[:config][:api_version]))
      klass = Object.const_get("Misty::Openstack::#{service.project.capitalize}::#{api_version.capitalize}")
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

    alias domain_name_server dns
    alias volume block_storage

    private

    # TODO, *args)
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
