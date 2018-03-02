require 'misty/client_pack'

def request_header
  {'Accept' => 'application/json; q=1.0'}
end

def service(param_content_type = :ruby, params = {})
  auth = Minitest::Mock.new

  def auth.get_url(*args)
    'http://localhost'
  end

  def auth.get_token
    'token_id'
  end

  params[:content_type] = param_content_type

  stub_request(:get, 'http://localhost/').
    with(:headers => request_header).
    to_return(:status => 200, :body => '', :headers => {})

  globals = Class.new do
    include Misty::Config

    attr_reader :config

    def initialize(args, auth)
      @config = set_config(args)
      @config[:auth] = auth
    end
  end

  args = globals.new(params, auth)

  Misty::Openstack::Neutron::V2_0.new(args.config)
end
