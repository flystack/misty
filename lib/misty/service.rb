module Misty
  class Service
    attr_reader :name, :microversion, :project, :versions

    def initialize(params)
      @name = params[:name]
      @project = params[:project]
      @versions = params[:versions]
      @microversion = params[:microversion]
    end

    def to_s
      res = "#{name}: #{project}"
      res << ", versions: #{@versions}" if @versions
      res << ", microversion: #{@microversion}" if @microversion
      res
    end

    def version(api_version = nil)
      if api_version
        return api_version if (@versions && @versions.include?(api_version)) || @microversion == api_version
      end
      default_version
    end

    def default_version
      return @microversion if @microversion
      return self.versions.sort[-1]
    end

    def version=(val)
      if @versions.include?(val)
        @version = val
      else
        # Use highest version
        @version = versions.sort[-1]
      end
    end
  end
end
