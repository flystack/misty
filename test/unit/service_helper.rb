require 'misty/client_pack'
require 'auth_helper'

def request_header
  {'Accept' => 'application/json; q=1.0'}
end

def service(param_content_type = :hash, params = {})
  arg = {
    :auth => {
      :url             => 'http://localhost:5000',
      :user_id         => 'user_id',
      :password        => 'secret',
      :project_id      => 'project_id',
      :ssl_verify_mode => false
    },
    :content_type => param_content_type,
  }
  arg.merge!(params)

  stub_request(:post, "http://localhost:5000/v3/auth/tokens").
    with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body =>  JSON.dump(auth_response_v3('network', 'neutron')), :headers => {'x-subject-token'=>'token_data'})

  config = Misty::Config.new(arg)

# TODO: remove
#  stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
#    with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
#    to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

  Misty::Openstack::Neutron::V2_0.new(config.get_service(:network))
end
