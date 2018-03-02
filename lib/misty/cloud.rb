require 'misty/config'
require 'misty/auth/auth_v2'
require 'misty/auth/auth_v3'
require 'misty/http/header'

module Misty

  # +Misty::Cloud+ is the main OpenStack cloud class.
  # An instance holds authentication information such as token, catalog and contains all available services as methods.
  #
  class Cloud
    include Misty::Config

    def self.dot_to_underscore(val)
      val.gsub(/\./,'_')
    end

    # ==== Attributes
    #
    # * +args+ - Hash of configuration parameters for authentication, log, and services options.
    #
    def initialize(args)
      @globals = set_config(args)
    end

    def build_service(method, arg)
      service = Misty.services.find {|service| service.name == method}
      version = self.class.dot_to_underscore(service.default_version(arg[:api_version]))
      klass = Object.const_get("Misty::Openstack::#{service.project.capitalize}::#{version.capitalize}")
      klass.new(set_config(arg, @globals))
    end

    def application_catalog(arg = {})
      if @application_catalog
        @application_catalog.set_ether_config(arg) if arg
        @application_catalog
      else
        @application_catalog = build_service(__method__, arg)
      end
    end

    def alarming(arg = {})
      if @alarming
        @alarming.set_ether_config(arg) if arg
        @alarming
      else
        @alarming = build_service(__method__, arg)
      end
    end

    def backup(arg = {})
      if @backup
        @backup.set_ether_config(arg) if arg
        @backup
      else
        @backup = build_service(__method__, arg)
      end
    end

    def baremetal(arg = {})
      if @baremetal
        @baremetal.set_ether_config(arg) if arg
        @baremetal
      else
        @baremetal = build_service(__method__, arg)
      end
    end

    def block_storage(arg = {})
      if @block_storage
        @block_storage.set_ether_config(arg) if arg
        @block_storage
      else
        @block_storage = build_service(__method__, arg)
      end
    end

    def clustering(arg = {})
      if @clustering
        @clustering.set_ether_config(arg) if arg
        @clustering
      else
        @clustering = build_service(__method__, arg)
      end
    end

    def compute(arg = {})
      if @compute
        @compute.set_ether_config(arg) if arg
        @compute
      else
        @compute = build_service(__method__, arg)
      end
    end

    def container_infrastructure_management(arg = {})
      if @container_infrastructure_management
        @container_infrastructure_management.set_ether_config(arg) if arg
        @container_infrastructure_management
      else
        @container_infrastructure_management = build_service(__method__, arg)
      end
    end

    def data_processing(arg = {})
      if @data_processing
        @data_processing.set_ether_config(arg) if arg
        @data_processing
      else
        @data_processing = build_service(__method__, arg)
      end
    end

    def data_protection_orchestration(arg = {})
      if @data_protection_orchestration
        @data_protection_orchestration.set_ether_config(arg) if arg
        @data_protection_orchestration
      else
        @data_protection_orchestration = build_service(__method__, arg)
      end
    end

    def database(arg = {})
      if @database
        @database.set_ether_config(arg) if arg
        @database
      else
        @database = build_service(__method__, arg)
      end
    end

    def dns(arg = {})
      if @dns
        @dns.set_ether_config(arg) if arg
        @dns
      else
        @dns = build_service(__method__, arg)
      end
    end

    def identity(arg = {})
      if @identity
        @identity.set_ether_config(arg) if arg
        @identity
      else
        @identity = build_service(__method__, arg)
      end
    end

    def image(arg = {})
      if @image
        @image.set_ether_config(arg) if arg
        @image
      else
        @image = build_service(__method__, arg)
      end
    end

    def load_balancer(arg = {})
      if @load_balancer
        @load_balancer.set_ether_config(arg) if arg
        @load_balancer
      else
        @load_balancer = build_service(__method__, arg)
      end
    end

    def messaging(arg = {})
      if @messaging
        @messaging.set_ether_config(arg) if arg
        @messaging
      else
        @messaging = build_service(__method__, arg)
      end
    end

    def metering(arg = {})
      if @metering
        @metering.set_ether_config(arg) if arg
        @metering
      else
        @metering = build_service(__method__, arg)
      end
    end

    def networking(arg = {})
      if @networking
        @networking.set_ether_config(arg) if arg
        @networking
      else
        @networking = build_service(__method__, arg)
      end
    end

    def nfv_orchestration(arg = {})
      if @nfv_orchestration
        @nfv_orchestration.set_ether_config(arg) if arg
        @nfv_orchestration
      else
        @nfv_orchestration = build_service(__method__, arg)
      end
    end

    def object_storage(arg = {})
      if @object_storage
        @object_storage.set_ether_config(arg) if arg
        @object_storage
      else
        @object_storage = build_service(__method__, arg)
      end
    end

    def orchestration(arg = {})
      if @orchestration
        @orchestration.set_ether_config(arg) if arg
        @orchestration
      else
        @orchestration = build_service(__method__, arg)
      end
    end

    def search(arg = {})
      if @search
        @search.set_ether_config(arg) if arg
        @search
      else
        @search = build_service(__method__, arg)
      end
    end

    def shared_file_systems(arg = {})
      if @shared_file_systems
        @shared_file_systems.set_ether_config(arg) if arg
        @shared_file_systems
      else
        @shared_file_systems = build_service(__method__, arg)
      end
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
