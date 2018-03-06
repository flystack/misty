require 'test_helper'
require 'auth_helper'
require 'misty/openstack/service'
require 'misty/microversion'
require 'misty/config'

describe Misty::Microversion do
  let(:versions_data) do
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

  let(:config) do
    arg = {
      :auth => {
        :url             => 'http://localhost:5000',
        :user_id         => 'user_id',
        :password        => 'secret',
        :project_id      => 'project_id',
        :ssl_verify_mode => false
      }
    }
    Misty::Config.new(arg)
  end

  let(:service) do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}",
        :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body =>  JSON.dump(auth_response_v3('compute', 'nova')), :headers => {})

    stub_request(:get, "http://localhost/").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => JSON.dump(versions_data), :headers => {})

    service = Misty::Openstack::Nova::V2_1.new(config.get_service(:compute))
  end

  describe '#version_get' do
    it 'returns the version number' do
      service.version_get('2.12').must_equal '2.12'
    end

    it 'returns the version number' do
      service.version_get('CURRENT').must_equal '2.25'
    end

    it 'fails when version is not within supporterd interval' do
      proc do
        service.version_get('2.0')
      end.must_raise Misty::Microversion::VersionError
    end

    it 'fails when LATEST version is not available' do
      proc do
        service.version_get('LATEST')
      end.must_raise Misty::Microversion::VersionError
    end

    it 'fails when using an invalid version State' do
      proc do
        service.version_get('OTHER')
      end.must_raise Misty::Microversion::VersionError
    end
  end
end
