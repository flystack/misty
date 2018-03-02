require 'logger'
require 'misty/auth/auth_v2'
require 'misty/auth/auth_v3'
require 'misty/http/header'

module Misty

  # Module setting up and validationg configuration parameters
  #
  # The configuration at the +Misty::Cloud+ level is global then local at +Misty::Cloud::Service+ level.
  # All parameters but +:auth+ are optionals and default values are defined if not specified.
  # +@globals+ holds all the configuration data which is passed each service when needed.
  #
  # ==== Authentication credentials options
  #
  # +:auth+ - Hash containing auhthentication URL and credentials details to authenticate against OpenStack identity
  # server Keystone.
  #
  # ==== Examples
  #
  #   require 'misty'
  #    auth = {
  #      :url                => 'http://localhost:5000',
  #      :user               => 'admin',
  #      :password           => 'secret',
  #      :domain             => 'default',
  #      :project            => 'admin',
  #      :project_domain_id  => 'default'
  #    }
  #    cloud = Misty::Cloud.new(:auth => auth, :log_file => './misty.log')

  module Config
    class InvalidDataError < StandardError; end

    # Default REST content type. Use :json or :ruby
    CONTENT_TYPE = :ruby

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

    # Valid content format
    CONTENT_TYPES = %i{ruby json}

    # ==== Attributes
    #
    # * +arg+ - +Hash+ of configuration options

    def set_config(arg = {}, defaults = {})
      set = {}
      set[:log] = set_log(arg[:log_file], arg[:log_level], defaults[:log])
      set[:auth] = set_auth(arg[:auth], defaults[:auth])
      set[:content_type] = set_content_type(arg[:content_type], defaults[:content_type])
      set[:headers] = set_headers(arg[:headers], defaults[:headers])
      set[:interface] = set_interface(arg[:interface], defaults[:interface])
      set[:region_id] = set_region_id(arg[:region_id], defaults[:region_id])
      set[:ssl_verify_mode] = set_ssl_verify_mode(arg[:ssl_verify_mode], defaults[:ssl_verify_mode])
      set
    end

    private

    def set_auth(val, default)
      if default
        default
      elsif val
        Misty::Auth.build(val)
      end
    end

    def set_content_type(val, default)
      res = if val
              val
            elsif default
              default
            else
              CONTENT_TYPE
            end
      raise InvalidDataError, "Config ':content_type' must be one of #{CONTENT_TYPES}" unless CONTENT_TYPES.include?(res)
      res
    end

    def set_headers(val, default)
      init = HTTP::Header.new('Accept' => 'application/json; q=1.0')
      res = if val && !val.empty?
              if default
                default.add(val)
                default
              else
                init.add(val)
                init
              end
            elsif default
              default
            else
              init
            end
      res
    end

    def set_interface(val, default)
      res = if val
              val
            elsif default
              default
            else
              INTERFACE
            end
      raise InvalidDataError, "Config ':interface' must be one of #{INTERFACES}" unless INTERFACES.include?(res)
      res
    end

    def set_log(log_file, log_level, default)
      log_file = set_log_file(log_file)
      log_level = set_log_level(log_level)

      if default
        default
      else
        log = Logger.new(log_file)
        log.level = log_level
        log
      end
    end

    def set_log_level(val)
      res = if val
              val
            else
              LOG_LEVEL
            end
      res
    end

    def set_log_file(val)
      res = if val
              val
            else
              LOG_FILE
            end
      res
    end

    def set_region_id(val, default)
      res = if val
              val
            elsif default
              default
            else
              REGION_ID
            end
      raise InvalidDataError, "Config ':region_id' must be a String" unless res.kind_of? String
      res
    end

    def set_ssl_verify_mode(val, default)
      res = if !val.nil?
              val
            elsif !default.nil?
              default
            else
              SSL_VERIFY_MODE
            end
      raise InvalidDataError, "Config ':ssl_verify_mode' must be a Boolean" unless res == !!res
      res
    end
  end
end
