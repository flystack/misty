require 'misty/client_pack'

def request_header
  {'Accept' => 'application/json; q=1.0'}
end

def service(content_type = :ruby, params = {})
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
  setup.headers = Misty::HTTP::Header.new('Accept' => 'application/json; q=1.0')

  stub_request(:get, 'http://localhost/').
    with(:headers => request_header).
    to_return(:status => 200, :body => '', :headers => {})

  Misty::Openstack::Neutron::V2_0.new(auth, setup, params)
end
