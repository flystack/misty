module Misty
  class Config
    attr_accessor :auth, :content_type, :headers, :interface, :log, :region_id, :ssl_verify_mode

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
