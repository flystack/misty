require 'yaml'
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

    def types
      list = []
      each do |s|
        list << s.type
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
