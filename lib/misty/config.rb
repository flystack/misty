require 'logger'
require 'misty/auth/token'

module Misty
  class Config
    # Default REST content type. Use :json or :hash
    CONTENT_TYPE = :hash

    # Valid content format
    CONTENT_TYPES = %i{hash json}

    # Default Interface
    INTERFACE = 'public'

    # Valid endpoint interfaces
    INTERFACES = %w(admin public internal)

    # Default Log file
    LOG_FILE  = '/dev/null'

    # Default Log level
    LOG_LEVEL = Logger::INFO

    # Default Region
    REGION = 'regionOne'

    # Default when uri.scheme is https
    SSL_VERIFY_MODE = true

    attr_reader :catalog, :token, :log, :services

    def initialize(arg)
      raise CredentialsError if arg.nil? || arg.empty? || arg[:auth].nil? || arg[:auth].empty?
      @log = set_log(arg[:log_file], arg[:log_level])
      @globals = set_config(arg)
      @services = set_services(arg)
      arg[:log] = @log
      @token = Misty::Auth::Token.build(arg[:auth])
    end

    def get_service(method)
      set = {}
      set[:token] = @token
      set[:log] = @log
      service_config = @services.key?(method) ? @services[method] : {}
      if service_config
        set[:config] = set_config(service_config, @globals)
        set[:config].merge!(set_service(service_config))
      else
        set[:config] = @globals
      end
      set
    end

    def set_service(arg)
      set = {}
      set[:api_version] = arg[:api_version] ? arg[:api_version] : nil
      set[:base_path] = arg[:base_path] ? arg[:base_path].chomp('/') : nil
      set[:endpoint] = arg[:endpoint] ? arg[:endpoint] : nil
      set[:service_name] = arg[:service_name] ? arg[:service_name] : nil
      set[:version] = arg[:version] ? arg[:version] : nil
      set
    end

    private

    def set_config(arg = {}, defaults = get_defaults)
      set = {}
      set[:content_type] = set_content_type(arg[:content_type], defaults[:content_type])
      set[:headers] = set_headers(arg[:headers], defaults[:headers])
      set[:interface] = set_interface(arg[:interface], defaults[:interface])
      set[:region] = set_region(arg[:region], defaults[:region])
      set[:ssl_verify_mode] = set_ssl_verify_mode(arg[:ssl_verify_mode], defaults[:ssl_verify_mode])
      set
    end

    def set_content_type(val, default)
      res = val.nil? ? default : val
      raise InvalidDataError, "Config ':content_type' must be one of #{CONTENT_TYPES}" unless CONTENT_TYPES.include?(res)
      res
    end

    def get_defaults
      set = {}
      set[:content_type] = CONTENT_TYPE
      set[:headers] = HTTP::Header.new('Accept' => 'application/json; q=1.0')
      set[:interface] = INTERFACE
      set[:region] = REGION
      set[:ssl_verify_mode] = SSL_VERIFY_MODE
      set
    end

    def set_headers(val, default)
      res = HTTP::Header.new
      res.add(default.get)
      res.add(val) if !val.nil? && !val.empty?
      res
    end

    def set_interface(val, default)
      res = val.nil? ? default : val
      raise InvalidDataError, "Config ':interface' must be one of #{INTERFACES}" unless INTERFACES.include?(res)
      res
    end

    def set_log(file, level)
      log = Logger.new(file ? file : LOG_FILE)
      log.level = level ? level : LOG_LEVEL
      log
    end

    def set_region(val, default)
        res = val.nil? ? default : val
      raise InvalidDataError, "Config ':region' must be a String" unless res.kind_of? String
      res
    end

    def set_services(arg)
      set = {}
      # TODO: Use enumerable
      arg.each do |e, k|
        Misty::SERVICES.each do |s|
          set[e] = k if s[:name] == e
        end
      end
      set
    end

    def set_ssl_verify_mode(val, default)
        res = val.nil? ? default : val
      raise InvalidDataError, "Config ':ssl_verify_mode' must be a Boolean" unless res == !!res
      res
    end
  end
end
