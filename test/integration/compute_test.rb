require 'test_helper'

describe 'Compute Service Nova v2.1 features' do
  it 'GET/POST/PUT/DELETE requests' do
    VCR.use_cassette 'compute using nova v2.1' do
      cloud = Misty::Cloud.new(:auth => auth, :compute => {:api_version => 'v2.1'})

      # POST with body data
      server = { 'name': 'test_create_server', 'flavorRef': '1', 'imageRef': 'c091ccf2-a4ae-4fa0-a716-defd6376b5dc', 'networks': [{'uuid': '9c6e43b6-3d1d-4106-ad45-5fc3f5e371ee'}]}
      response = cloud.compute.create_server('server' => server)
      response.code.must_equal '202'
      id = response.body['server']['id']
      id.wont_be_empty

      # GET
      response = cloud.compute.list_servers
      response.code.must_equal '200'
      response.body['servers'].size.must_equal 2

      # GET with URI value
      response = cloud.compute.show_server_details(id)
      response.code.must_equal '200'
      response.body['server']['name'].must_equal 'test_create_server'

      # PUT with URI value and body data
      update_server = { 'name': 'test_updated_server' }
      response = cloud.compute.update_server(id, 'server' => update_server)
      response.code.must_equal '200'
      response.body['server']['name'].must_equal 'test_updated_server'

      # DELETE with URI value
      cloud.compute.delete_server(id).code.must_equal '204'
    end
  end
end
