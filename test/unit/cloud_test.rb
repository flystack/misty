require 'test_helper'
require 'auth_helper'

describe Misty::Cloud do
  describe '#dot_to_underscore' do
    it 'returns a valid name' do
      name = Misty::Cloud.dot_to_underscore('v20.90.01')
      name.must_equal 'v20_90_01'
    end
  end

  describe 'identity' do
    let(:arg) do
      arg = {
        :auth => {
          :url             => 'http://localhost:5000',
          :user_id         => 'user_id',
          :password        => 'secret',
          :project_id      => 'project_id',
          :ssl_verify_mode => false
        },
      }
    end

    let(:auth_request) do
      stub_request(:post, "http://localhost:5000/v3/auth/tokens").
        with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body =>  JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})
    end

    it 'uses default version' do
      auth_request
      cloud = Misty::Cloud.new(arg)
      cloud.identity.must_be_kind_of Misty::Openstack::API::Keystone::V3
    end

    it 'uses default version when provided version is out of range' do
      auth_request
      arg.merge!(:identity => {:api_version => 'v1'})
      cloud = Misty::Cloud.new(arg)
      cloud.identity.must_be_kind_of Misty::Openstack::API::Keystone::V3
    end

    it 'uses provided version' do
      auth_request
      arg.merge!(:identity => {:api_version => 'v2.0'})
      cloud = Misty::Cloud.new(arg)
      cloud.identity.must_be_kind_of Misty::Openstack::API::Keystone::V2_0
    end
  end

  describe 'Each service' do
    it 'has a method defined' do
      Misty::services.each do |service|
        method =  Misty::Cloud.method_defined?(service.name)
        method.must_equal true
      end
    end
  end

  describe '#new' do
    describe 'fails' do
      it 'when no parameters' do
        proc do
          Misty::Cloud.new
        end.must_raise ArgumentError
      end

      it 'with empty credentials' do
        proc do
          Misty::Cloud.new(:auth => {})
        end.must_raise Misty::Config::CredentialsError
      end

      it 'with incomplete credentials' do
        proc do
          Misty::Cloud.new(:auth => {:user => 'user', :url => 'http://localhost' })
        end.must_raise Misty::Config::CredentialsError
      end

      it 'without url' do
        authv3_data = {
          :user     => 'admin',
          :password => 'secret',
          :project  => 'admin'
        }

        proc do
          Misty::Cloud.new(:auth => authv3_data)
        end.must_raise Misty::Auth::Token::URLError
      end

      it 'with empty url' do
        authv3_data = {
          :url      => '',
          :user     => 'admin',
          :password => 'secret',
          :project  => 'admin'
        }

        proc do
          Misty::Cloud.new(:auth => authv3_data)
        end.must_raise Misty::Auth::Token::URLError
      end
    end

    describe 'Authenticates' do
      describe 'with v2 credentials' do
        let(:authv2_data) do
          {
            :url      => 'http://localhost:5000',
            :user     => 'admin',
            :password => 'secret',
            :tenant   => 'admin'
          }
        end

        it 'uses Misty::Auth::Token::V3' do
          authv2 = Minitest::Mock.new

            Misty::Auth::Token::V2.stub :new, authv2 do
            cloud = Misty::Cloud.new(:auth => authv2_data)
            assert_mock authv2
          end
        end
      end

      describe 'with v3 credentials' do
        let(:authv3_data) do
          {
            :url      => 'http://localhost:5000',
            :user     => 'admin',
            :password => 'secret',
            :project  => 'admin'
          }
        end

        it 'uses Misty::Auth::Token::V3' do
          authv3 = Minitest::Mock.new

          Misty::Auth::Token::V3.stub :new, authv3 do
            cloud = Misty::Cloud.new(:auth => authv3_data)
            assert_mock authv3
          end
        end
      end
    end
  end
end
