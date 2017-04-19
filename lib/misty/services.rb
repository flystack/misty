module Misty
  class Services
    class Service
      attr_reader :name, :options, :project, :versions, :version

      def initialize(name, project, versions)
        @name = name
        @project = project
        @versions = versions
        @options = {}
      end

      def options=(val)
        @options = val
      end

      def version=(val)
        if @versions.include?(val)
          @version = val
        else
          # Use highest version
          @version = versions.sort[-1]
        end
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
