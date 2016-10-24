require 'misty/auth/auth_v2'
require 'misty/auth/auth_v3'

module Misty
  class Cloud
    Setup   = Struct.new(:auth, :content_type, :log)

    Options = Struct.new(:alarming, :baremetal, :block_storage, :clustering, :compute, :container, :data_processing,
      :database, :data_protection, :dns, :identity, :image, :messaging, :metering, :network, :object_storage,
      :orchestration, :search, :shared_file_systems)

    attr_reader :services

    def initialize(options = {:auth => {}})
      @cloud = Setup.new
      @cloud.auth = Misty::Auth.factory(options[:auth])
      @cloud.content_type = options[:content_type] ? options[:content_type] : nil
      @cloud.log = Logger.new(options[:log_file] ? options[:log_file] : Misty::LOG_FILE)
      @cloud.log.level = options[:log_level] ? options[:log_level] : Misty::LOG_LEVEL

      @options = Options.new
      Misty.services.each do |service|
        @options.send("#{service.name}=".to_sym, options[service.name] ? options[service.name] : {})
      end

      @services = setup_services(@options)
    end

    def setup_services(options)
      services = {}
      Misty.services.each do |service|
        if options[service.name] && options[service.name][:api_version] \
          && service.versions.include?(options[service.name][:api_version])
          services.merge!(service.name => {service.project => options[service.name][:api_version]})
        else
          # Highest version is used by default!
          services.merge!(service.name => {service.project => service.versions.sort[-1]})
        end
      end
      services
    end

    def build_service(service_name)
      project = @services[service_name].keys[0]
      version = @services[service_name].fetch(project)
      version = self.class.dot_to_underscore(version)
      klass = Object.const_get("Misty::Openstack::#{project.capitalize}::#{version.capitalize}")
      klass.new(@cloud, @options[service_name])
    end

    def self.dot_to_underscore(val)
      val.gsub(/\./,'_')
    end

    def alarming
      @alarming ||= build_service(:alarming)
    end

    def baremetal
      @baremetal ||= build_service(:baremetal)
    end

    def block_storage
      @block_storage ||= build_service(:block_storage)
    end

    alias volume block_storage

    def clustering
      @clustering ||= build_service(:clustering)
    end

    def compute
      @compute ||= build_service(:compute)
    end

    def container
      @container ||= build_service(:container)
    end

    def data_processing
      @data_processing ||= build_service(:data_processing)
    end

    def data_protection
      @data_protection ||= build_service(:data_protection)
    end

    def database
      @database ||= build_service(:database)
    end

    def dns
      @dns ||= build_service(:dns)
    end

    def identity
      @identity ||= build_service(:identity)
    end

    def image
      @image ||= build_service(:image)
    end

    def messaging
      @messaging ||= build_service(:messaging)
    end

    def metering
      @metering ||= build_service(:metering)
    end

    def network
      @network ||= build_service(:network)
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
  end
end
