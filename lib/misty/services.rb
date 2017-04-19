module Misty
  class Services
    class Service
      attr_reader :name, :project, :versions

      def initialize(name, project, versions)
        @name = name
        @project = project
        @versions = versions
      end

      def to_s
        "#{name}: #{project} => #{versions}"
      end
    end

    include Enumerable

    attr_reader :services

    def initialize
      @services = []
    end

    def add(*args)
      @services << Service.new(*args)
    end

    def each
      @services.each do |service|
        yield service
      end
    end
  end
end
