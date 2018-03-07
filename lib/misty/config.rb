require 'logger'
require 'misty/auth/auth_v2'
require 'misty/auth/auth_v3'
require 'misty/http/header'

module Misty
  class Config
    # Default REST content type. Use :json or :hash
    CONTENT_TYPE = :hash

    # Valid content format
    CONTENT_TYPES = %i{hash json}

    # Default Interface
    INTERFACE = 'public'

    # Valid endpoint interfaces
    INTERFACES = %w{admin public internal}

    # Default Log file
    LOG_FILE  = '/dev/null'

    # Default Log level
    LOG_LEVEL = Logger::INFO

    # Default Region
    REGION_ID = 'regionOne'

    # Default when uri.scheme is https
    SSL_VERIFY_MODE = true

    # ==== Attributes
    #
    # * +arg+ - +Hash+ of configuration options

    attr_reader :auth, :log, :services

    def initialize(arg)
      raise CredentialsError if arg.nil? || arg.empty? || arg[:auth].nil? || arg[:auth].empty?
      @auth = Misty::Auth.build(arg[:auth]) # TODO: pass @log
      @log = set_log(arg[:log_file], arg[:log_level])
      @globals = set_config(arg)
      @services = {}
      # TODO: Adjust Services to use enumerable
      arg.each do |e, k|
        Misty::SERVICES.each do |serv|
          @services[e] = k if serv[:name] == e
        end
      end
    end

    def get_service(method)
      set = {}
      set[:auth] = @auth
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
      set[:base_path] = arg[:base_path] ? arg[:base_path] : nil
      set[:base_url] = arg[:base_url] ? arg[:base_url] : nil
      set[:version] = arg[:version] ? arg[:version] : nil
      set[:api_version] = arg[:api_version] ? arg[:api_version] : nil
      set
    end

    private

    def get_defaults
      set = {}
      set[:content_type] = CONTENT_TYPE
      set[:headers] = HTTP::Header.new('Accept' => 'application/json; q=1.0')
      set[:interface] = INTERFACE
      set[:region_id] = REGION_ID
      set[:ssl_verify_mode] = SSL_VERIFY_MODE
      set
    end

    def set_config(arg = {}, defaults = get_defaults)
      set = {}
      set[:content_type] = set_content_type(arg[:content_type], defaults[:content_type])
      set[:headers] = set_headers(arg[:headers], defaults[:headers])
      set[:interface] = set_interface(arg[:interface], defaults[:interface])
      set[:region_id] = set_region_id(arg[:region_id], defaults[:region_id])
      set[:ssl_verify_mode] = set_ssl_verify_mode(arg[:ssl_verify_mode], defaults[:ssl_verify_mode])
      set
    end


    def set_content_type(val, default)
      res = val.nil? ? default : val
      raise InvalidDataError, "Config ':content_type' must be one of #{CONTENT_TYPES}" unless CONTENT_TYPES.include?(res)
      res
    end

    def set_headers(val, default)
      res = if val && !val.empty?
              default.add(val)
              default
            else default
              default
            end
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

    def set_region_id(val, default)
        res = val.nil? ? default : val
      raise InvalidDataError, "Config ':region_id' must be a String" unless res.kind_of? String
      res
    end

    def set_ssl_verify_mode(val, default)
        res = val.nil? ? default : val
      raise InvalidDataError, "Config ':ssl_verify_mode' must be a Boolean" unless res == !!res
      res
    end
  end
end
