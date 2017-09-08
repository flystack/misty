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
      str = "#{name}: #{project}"
      str << ", versions: #{@versions}" if @versions
      str << ", microversion: #{@microversion}" if @microversion
      str
    end

    def version(api_version = nil)
      if api_version
        return api_version if (@versions && @versions.include?(api_version)) || @microversion == api_version
      end
      default_version
    end

    private

    def default_version
      return @microversion if @microversion
      return self.versions.sort[-1]
    end
  end
end
