require 'misty/http/client'

def request_header
  {'Accept' => 'application/json'}
end

def service(content_type = :ruby)
  auth = Minitest::Mock.new

  def auth.get_url(*args)
    'http://localhost'
  end

  def auth.get_token
    'token_id'
  end

  setup = Misty::Cloud::Config.new
  setup.content_type = content_type
  setup.log = Logger.new('/dev/null')
  setup.interface = Misty::INTERFACE
  setup.region_id = Misty::REGION_ID
  setup.ssl_verify_mode = Misty::SSL_VERIFY_MODE

  stub_request(:get, 'http://localhost/').
    with(:headers => request_header).
    to_return(:status => 200, :body => '', :headers => {})

  Misty::Openstack::Neutron::V2_0.new(auth, setup, {})
end
