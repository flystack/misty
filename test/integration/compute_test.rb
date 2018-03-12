require 'test_helper'


describe 'Compute Service Nova v2.1 features' do
  let(:auth) do
    {
      :url                => 'http://192.0.2.6:5000',
      :user               => 'admin',
      :password           => 'QJdEmBzzEJpfpeRY6e3TEk7TW',
      :project            => 'admin',
      :project_domain_id  => 'default',
      :domain             => 'default'
    }
  end

  it 'GET/POST/PUT/DELETE requests' do
    VCR.use_cassette 'compute using nova v2.1' do
      cloud = Misty::Cloud.new(:auth => auth, :compute => {:api_version => 'v2.1'})

      # POST with body data
      server = { 'name': 'test_create_server', 'flavorRef': '1', 'imageRef': '07bd625e-d3ae-415c-bc82-46d66168378a', 'networks': [{'uuid': '204e3939-34d2-40af-b52d-f58cfec1e2b1'}]}
      data = Misty::Helper.to_json('server' => server)
      response = cloud.compute.create_server(data)
      response.code.must_equal '202'
      id = response.body['server']['id']
      id.wont_be_empty

      # GET
      response = cloud.compute.list_servers
      response.code.must_equal '200'
      response.body['servers'].size.must_equal 1
      # GET with URI value
      response = cloud.compute.show_server_details(id)
      response.code.must_equal '200'
      response.body['server']['name'].must_equal 'test_create_server'

      # PUT with URI value and body data
      update_server = { 'name': 'test_updated_server' }
      data = Misty::Helper.to_json('server' => update_server)
      response = cloud.compute.update_server(id, data)
      response.code.must_equal '200'
      response.body['server']['name'].must_equal 'test_updated_server'

      # DELETE with URI value
      cloud.compute.delete_server(id).code.must_equal '204'
    end
  end
end
