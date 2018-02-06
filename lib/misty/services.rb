require 'misty/service'

module Misty
  class Services
    include Enumerable

    attr_reader :services

    def initialize
      @services = []
    end

    def add(*args)
      @services << Misty::Service.new(*args)
    end

    def each
      @services.each do |service|
        yield service
      end
    end

    def get(name)
      @services.each do |service|
        return service if service.name == name
      end
    end

    def names
      service_names = []
      @services.each do |service|
        service_names << service.name
      end
      service_names
    end

    def to_s
      list = ''
      @services.each do |service|
        list << service.to_s + "\n"
      end
      list
    end
  end
end
