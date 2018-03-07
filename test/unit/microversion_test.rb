require 'test_helper'
require 'auth_helper'
require 'misty/microversion'
require 'misty/http/request'

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
          'version' => '2.60',
          'id' => 'v2.1' }] }
  end

  describe '#set_version' do
    let(:service) do
      service = Object.new
      service.extend(Misty::Microversion)

      def service.headers
        @headers = Misty::HTTP::Header.new
      end
      service.headers
      service
    end

    describe 'fetch versions' do
      before do
        service.extend(Misty::HTTP::Request)

        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

        def service.setup
          @uri = URI.parse('http://localhost/')
          @log = Logger.new('/dev/null')
          @auth = Misty::AuthV3.new(
            :url             => 'http://localhost:5000',
            :user_id         => 'user_id',
            :password        => 'secret',
            :project_id      => 'project_id'
          )
        end
        service.setup
      end

      let(:fetch_request) do
        stub_request(:get, "http://localhost/").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby', 'X-Auth-Token'=>'token_data'}).
        to_return(:status => 200, :body => JSON.dump(versions_data), :headers => {})
      end

      it 'set microversion when number within min/max range' do
        fetch_request

        def service.service_names
          %w{service_name1}
        end

        service.microversion_header('2.60').must_equal({"X-Openstack-API-Version" => "service_name1 2.60"})
      end

      it 'fails when asked version is not within min-max range' do
        fetch_request

        proc do
          service.set_version('3.20')
        end.must_raise Misty::Microversion::VersionError
      end
    end

    it "set microversion to 'latest'" do
      def service.service_names
        %w{service_name2}
      end
      service.microversion_header('latest').must_equal({"X-Openstack-API-Version" => "service_name2 latest"})
    end

    it 'fails when version is a wrong word' do
      proc do
        service.set_version('testing')
      end.must_raise Misty::Microversion::VersionError
    end

    it "fails when version does't match <number.number>" do
      proc do
        service.set_version('1.2.3')
      end.must_raise Misty::Microversion::VersionError
    end
  end
end
