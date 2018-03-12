module Misty
  class Service
    attr_reader :type, :microversion, :project, :versions

    def initialize(params)
      @type = params[:type]
      @project = params[:project]
      @versions = params[:versions]
      @microversion = params[:microversion]
    end

    def to_s
      str = "#{type}: #{project}"
      str << ", versions: #{@versions}" if @versions
      str << ", microversion: #{@microversion}" if @microversion
      str
    end

    def default_version(api_version = nil)
      res = if api_version && (@versions&.include?(api_version))
              api_version
            else
              self.versions.sort[-1]
            end
      res
    end
  end
end
