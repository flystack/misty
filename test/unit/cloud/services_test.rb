require 'test_helper'
require 'auth_helper'

describe 'Misty::Cloud' do
  let(:auth) do
    {
      :url               => 'http://localhost:5000',
      :user              => 'admin',
      :password          => 'secret',
      :project           => 'admin',
      :project_domain_id => 'default'
    }
  end

  let(:cloud) do
    Misty::Cloud.new(:auth => auth)
  end

  let(:auth_body) do
    { 'auth' => {
      'identity' => {
        'methods' => ['password'],
        'password' => {
          'user' => {
            'name' => 'admin',
            'domain'   => { 'id' => 'default' },
            'password' => 'secret'
          }
        }
      },
      'scope' => { 'project' => { 'name' => 'admin', 'domain' => { 'id' => 'default' } } }
    } }
  end

  let(:auth_headers) do
    { 'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby' }
  end

  let(:versions) do
    { 'versions' =>
      [{ 'status' => 'SUPPORTED',
        'updated' => '2011-01-21T11:33:21Z',
        'links' => [{ 'href' => 'http://localhost/v2/', 'rel' => 'self' }],
        'min_version' => '',
        'version' => '',
        'id' => 'v2.0' },
        { 'status' => 'CURRENT',
          'updated' => '2013-07-23T11:33:21Z',
          'links' => [{ 'href' => 'http://localhost/v2.1/', 'rel' => 'self' }],
          'min_version' => '2.1',
          'version' => '2.25',
          'id' => 'v2.1' }] }
  end

  let(:token_header) { {'x-subject-token'=>'token_data'} }

  it 'fails when method is missing' do
    proc do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('compute', 'nova')), :headers => token_header)

      stub_request(:get, 'http://localhost/').
        with(:headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

      cloud.compute.undefined_method
    end.must_raise NoMethodError
  end

  it '#backup' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('backup', 'freezer')), :headers => token_header)

    cloud.backup.must_be_kind_of Misty::Openstack::Freezer::V1
  end

  it '#baremetal' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('baremetal', 'ironic')), :headers => token_header)

    stub_request(:get, 'http://localhost/').
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.baremetal.must_be_kind_of Misty::Openstack::Ironic::V1
  end

  it '#blockStorage' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('volume', 'cinder')), :headers => token_header)

    stub_request(:get, 'http://localhost/').
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.block_storage.must_be_kind_of Misty::Openstack::Cinder::V3
  end

  describe '#compute' do
    it 'without microversion provided' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('compute', 'nova')), :headers => token_header)

      stub_request(:get, 'http://localhost/').
        with(:headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

      cloud.compute.must_be_kind_of Misty::Openstack::Nova::V2_1
    end

    it 'with microversion provided' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('compute', 'nova')), :headers => token_header)

      stub_request(:get, 'http://localhost/').
        with(:headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

      compute_cloud = Misty::Cloud.new(:auth => auth, :compute => {:version => '2.17'})

      compute_cloud.compute.must_be_kind_of Misty::Openstack::Nova::V2_1

      stub_request(:get, "http://localhost/servers").
        with(:headers => {'Accept'=>'application/json; q=1.0', 'X-Auth-Token'=>'token_data', 'X-Openstack-Nova-Api-Version'=>'2.17'})

      compute_cloud.compute.list_servers

      stub_request(:get, "http://localhost/servers").
        with(:headers => {'Accept'=>'application/json; q=1.0', 'X-Auth-Token'=>'token_data', 'X-Openstack-Nova-Api-Version'=>'2.19'})

      compute_cloud.compute(:version => '2.19').list_servers
    end
  end

  it '#dataProcessing' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('data-processing', 'sahara')), :headers => token_header)

    cloud.data_processing.must_be_kind_of Misty::Openstack::Sahara::V1_1
  end

  it '#identity' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => token_header)

    cloud.identity.must_be_kind_of Misty::Openstack::Keystone::V3
  end

  it '#image' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('image', 'glance')), :headers => token_header)

    cloud.image.must_be_kind_of Misty::Openstack::Glance::V2
  end

  it '#load_balancer' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('load-balancer', 'octavia')), :headers => token_header)

    cloud.load_balancer.must_be_kind_of Misty::Openstack::Octavia::V2_0
  end

  it '#networking' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('networking', 'neutron')), :headers => token_header)

    cloud.networking.must_be_kind_of Misty::Openstack::Neutron::V2_0
  end

  it '#nfv_orchestration' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('nfv-orchestration', 'tacker')), :headers => token_header)

    cloud.nfv_orchestration.must_be_kind_of Misty::Openstack::Tacker::V1_0
  end

  describe '#objectStorage' do
    it 'initialize with success' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('object-store', 'swift')), :headers => token_header)

      cloud.object_storage.must_be_kind_of Misty::Openstack::Swift::V1
    end

    it 'execute bulk_delete' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('object-store', 'swift')), :headers => token_header)

      stub_request(:post, "http://localhost/?bulk-delete=1").
        with(:headers => {'Accept'=>'application/json; q=1.0', 'Content-Type'=>'text/plain', 'User-Agent'=>'Ruby', 'X-Auth-Token'=>'token_data'}).
        to_return(:status => 200, :body => "", :headers => {})

      cloud.object_storage.requests.must_include :bulk_delete
      cloud.object_storage.bulk_delete("container1/object1")
    end
  end

  it '#orchestration' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('orchestration', 'heat')), :headers => token_header)

    cloud.orchestration.must_be_kind_of Misty::Openstack::Heat::V1
  end

  it '#search' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('search', 'searchlight')), :headers => token_header)

    cloud.search.must_be_kind_of Misty::Openstack::Searchlight::V1
  end

  it '#sharedFileSystems' do
    stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3('shared-file-systems', 'manila')), :headers => token_header)

    stub_request(:get, 'http://localhost/').
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.shared_file_systems.must_be_kind_of Misty::Openstack::Manila::V2
  end

  describe 'prefixed service name' do
    it '#network match networking' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('networking', 'neutron')), :headers => token_header)

      cloud.network.must_be_kind_of Misty::Openstack::Neutron::V2_0
    end

    it '#data is ambiguous' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('Identity', 'keystone')), :headers => token_header)

      proc do
        cloud.data
      end.must_raise NoMethodError
    end
  end
end
