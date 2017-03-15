require 'misty/http/client'

def request_header
  {'Accept'=>'application/json', 'Content-Type'=>'application/json'}
end

def service(content_type = :ruby)
  auth = Minitest::Mock.new

  def auth.get_endpoint(*args)
    "http://localhost"
  end

  def auth.get_token
    "token_id"
  end

  setup = Misty::Cloud::Setup.new(auth, content_type, Logger.new('/dev/null'), Misty::INTERFACE, Misty::REGION_ID, Misty::SSL_VERIFY_MODE)

  stub_request(:get, "http://localhost/").
    with(:headers => request_header).
    to_return(:status => 200, :body => "", :headers => {})

  Misty::Openstack::Neutron::V2_0.new(setup, {})
end
