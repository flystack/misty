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

    def default_version(api_version = nil)
      res = if api_version && (@versions&.include?(api_version) || api_version == @microversion)
              api_version
            elsif @microversion
              @microversion
            else
              self.versions.sort[-1]
            end
      res
    end
  end
end
