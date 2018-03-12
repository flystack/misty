require 'yaml'
require 'misty/service'

module Misty
  class Services
    include Enumerable

    attr_reader :services

    def self.build(file)
      services_list = Misty::Services.new
      openstack_services = YAML::load_file(file)
      openstack_services.each do |s|
        services_list.add(s)
      end
      services_list
    end

    def initialize
      @services = []
    end

    def add(*args)
      @services << Misty::Service.new(*args)
    end

    def each
      @services.each do |s|
        yield s
      end
    end

    def get(name)
      each do |s|
        return s if s.name == name
      end
      nil
    end

    def names
      list = []
      each do |s|
        list << s.name
      end
      list
    end

    def to_s
      list = ''
      each do |service|
        list << service.to_s + "\n"
      end
      list
    end
  end
end
