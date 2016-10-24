require 'test_helper'
require 'auth_helper'

describe "Misty::Cloud" do
  let(:cloud) do
    auth = {
      :url      => "http://localhost:5000",
      :user     => "admin",
      :password => "secret",
      :project  => "admin",
      :domain   => "default"
    }

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
      'Content-Type'    => 'application/json',
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

  let(:token_header) { {"x-subject-token"=>"token_data"} }

  it "fails when method is missing" do
    proc do
      stub_request(:post, "http://localhost:5000/v3/auth/tokens").
        with(:body => JSON.dump(auth_body), :headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3("compute", "nova")), :headers => token_header)

      stub_request(:get, "http://localhost/").
        with(:headers => auth_headers).
        to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

      cloud.compute.undefined_method
    end.must_raise NoMethodError
  end

  it "#baremetal" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("baremetal", "ironic")), :headers => token_header)

    stub_request(:get, "http://localhost/").
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.baremetal.must_be_kind_of Misty::Openstack::Ironic::V1
  end

  it "#blockStorage" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("volume", "cinder")), :headers => token_header)

    cloud.block_storage.must_be_kind_of Misty::Openstack::Cinder::V3
  end

  it "#compute" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("compute", "nova")), :headers => token_header)

    stub_request(:get, "http://localhost/").
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.compute.must_be_kind_of Misty::Openstack::Nova::V2_1
  end

  it "#dataProcessing" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("data-processing", "sahara")), :headers => token_header)

    cloud.data_processing.must_be_kind_of Misty::Openstack::Sahara::V1_1
  end

  it "#identity" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("identity", "keystone")), :headers => token_header)

    cloud.identity.must_be_kind_of Misty::Openstack::Keystone::V3
  end

  it "#image" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("image", "glance")), :headers => token_header)

    cloud.image.must_be_kind_of Misty::Openstack::Glance::V2
  end

  it "#network" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("network", "neutron")), :headers => token_header)

    cloud.network.must_be_kind_of Misty::Openstack::Neutron::V2_0
  end

  it "#objectStorage" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("object-store", "swift")), :headers => token_header)

    cloud.object_storage.must_be_kind_of Misty::Openstack::Swift::V1
  end

  it "#orchestration" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("orchestration", "heat")), :headers => token_header)

    cloud.orchestration.must_be_kind_of Misty::Openstack::Heat::V1
  end

  it "#search" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("search", "searchlight")), :headers => token_header)

    cloud.search.must_be_kind_of Misty::Openstack::Searchlight::V1
  end

  it "#sharedFileSystems" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => JSON.dump(auth_body), :headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("shared-file-systems", "manila")), :headers => token_header)

    stub_request(:get, "http://localhost/").
      with(:headers => auth_headers).
      to_return(:status => 200, :body => JSON.dump(versions), :headers => {})

    cloud.shared_file_systems.must_be_kind_of Misty::Openstack::Manila::V2
  end
end
