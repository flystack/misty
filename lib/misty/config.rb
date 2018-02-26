module Misty
  class Config
    attr_accessor :auth, :content_type, :headers, :interface, :log, :region_id, :ssl_verify_mode

    # Following options are global to all services unless specifically provided for a service.
    # * :content_type
    #   Format of the body of the successful HTTP responses to be JSON or Ruby structures.
    #   Type: Symbol
    #   Allowed values: `:json`, `:ruby`
    #   Default: `:ruby`
    # * :headers
    #   HTTP Headers to be applied to all services
    #   Type: Hash
    #   Default: {}
    # * :region_id
    #   Type: String
    #   Default: "regionOne"
    # * :interface
    #   Type: String
    #   Allowed values: "public", "internal", "admin"
    #   Default: "public"
    # * :ssl_verify_mode
    #   When using SSL mode (defined by URI scheme => "https://")
    #   Type: Boolean
    #   Default: `true`
    def initialize(params = {})
      @log = Logger.new(params[:log_file] ? params[:log_file] : Misty::LOG_FILE)
      @log.level = params[:log_level] ? params[:log_level] : Misty::LOG_LEVEL

      @headers = Misty::HTTP::Header.new('Accept' => 'application/json; q=1.0')
      @headers.add(params[:headers]) if params[:headers] && !params[:headers].empty?

      @content_type = params[:content_type] ? params[:content_type] : Misty::CONTENT_TYPE
      @interface = params[:interface] ? params[:interface] : Misty::INTERFACE
      @region_id = params[:region_id] ? params[:region_id] : Misty::REGION_ID
      @ssl_verify_mode = params.key?(:ssl_verify_mode) ? params[:ssl_verify_mode] : Misty::SSL_VERIFY_MODE
    end
  end
end
