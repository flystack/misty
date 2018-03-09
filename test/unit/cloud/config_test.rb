require 'test_helper'
require 'auth_helper'
require 'misty/config'

describe Misty::Config do
  describe 'without auth' do
    it 'fails' do
      proc do
        Misty::Config.new({})
      end.must_raise Misty::Config::CredentialsError
    end
  end

  describe 'with auth' do
    let(:auth) do
      {
        :url             => 'http://localhost:5000',
        :user_id         => 'user_id',
        :password        => 'secret',
        :project_id      => 'project_id',
        :ssl_verify_mode => false
      }
    end

    let(:auth_request) do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})
    end

    describe 'fails' do
      it 'with wrong header type' do
        auth_request
        proc do
          Misty::Config.new(:auth => auth, :headers => :blah)
        end.must_raise Misty::HTTP::Header::TypeError
      end

      it 'with interface wrong type' do
        auth_request
        proc do
          Misty::Config.new(:auth => auth, :interface => 'something')
        end.must_raise Misty::Config::InvalidDataError
      end

      it 'with region wrong type' do
        auth_request
        proc do
          Misty::Config.new(:auth => auth, :region => true)
        end.must_raise Misty::Config::InvalidDataError
      end

      it 'with ssl_verify_mode wrong type' do
        auth_request
        proc do
          Misty::Config.new(:auth => auth, :ssl_verify_mode => 'something')
        end.must_raise Misty::Config::InvalidDataError
      end
    end

    describe "success" do
      it 'using Cloud level defaults' do
        auth_request
        config = Misty::Config.new(:auth => auth)
        def config.globals
          @globals
        end

        config.log.must_be_kind_of Logger
        config.token.must_be_kind_of Misty::Auth::Token::V3
        config.globals[:content_type].must_equal Misty::Config::CONTENT_TYPE
        config.globals[:headers].must_be_kind_of Misty::HTTP::Header
        config.globals[:headers].get.must_equal("Accept"=>"application/json; q=1.0")
        config.globals[:interface].must_equal Misty::Config::INTERFACE
        config.globals[:region].must_equal Misty::Config::REGION
        config.globals[:ssl_verify_mode].must_equal Misty::Config::SSL_VERIFY_MODE
      end

      it 'with Cloud level parameters' do
        auth_request

        LOG_FILE_NAME = "./misty-unit_test-#{Process.pid}"
        config = Misty::Config.new(
          :auth            => auth,
          :content_type    => :json,
          :headers         => {'var' => 'value'},
          :interface       => 'admin',
          :region          => 'regionTest',
          :ssl_verify_mode => false,
          :log_file        => LOG_FILE_NAME
        )

        def config.globals
          @globals
        end

        config.globals[:content_type].must_equal :json
        config.globals[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'var' => 'value')
        config.globals[:interface].must_equal 'admin'
        config.globals[:region].must_equal 'regionTest'
        config.globals[:ssl_verify_mode].must_equal false
        File.exist?(LOG_FILE_NAME).must_equal true
        File.delete(LOG_FILE_NAME) if File.exist?(LOG_FILE_NAME)
      end

      describe 'with no global Cloud defined parameters'  do
        it 'set Service defined parameters' do
          auth_request
          config = Misty::Config.new(
            :auth       => auth,
            :compute    => {
              :content_type    => :json,
              :headers         => {'Service Key' => 'Service Value'},
              :interface       => 'internal',
              :region          => 'region local',
              :ssl_verify_mode => false,

              :base_path       => 'base_path_test',
              :endpoint        => 'https://service.example.com:8080',
              :service_name    => 'service1',
              :version         => 'vtest'
            }
          )

          service = config.get_service(:compute)
          service[:config][:content_type].must_equal :json
          service[:config][:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Service Key' => 'Service Value')
          service[:config][:interface].must_equal 'internal'
          service[:config][:region].must_equal 'region local'
          service[:config][:ssl_verify_mode].must_equal false

          service[:config][:base_path].must_equal 'base_path_test'
          service[:config][:endpoint].must_equal 'https://service.example.com:8080'
          service[:config][:service_name].must_equal 'service1'
          service[:config][:version].must_equal 'vtest'
        end
      end

      describe 'with global Cloud defined parameters' do
        let(:config) do
          auth_request
          Misty::Config.new(
           :auth            => auth,
           :content_type    => :json,
           :headers         => {'Global Key' => 'Global Value'},
           :interface       => 'internal',
           :region          => 'region_global',
           :ssl_verify_mode => false,
           :network => {
             :content_type    => :hash,
             :headers         => {'Local Key' => 'Local Value'},
             :interface       => 'admin',
             :region          => 'region_local',
             :ssl_verify_mode => true,

             :base_path       => 'base_path_test',
             :endpoint        => 'https://service1.example.com:8888',
             :service_name    => 'service1',
             :version         => '2.10'
           })
        end

        it 'set globals' do
          def config.globals
            @globals
          end

          config.globals[:content_type].must_equal :json
          config.globals[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Global Key' => 'Global Value')
          config.globals[:interface].must_equal "internal"
          config.globals[:region].must_equal "region_global"
          config.globals[:ssl_verify_mode].must_equal false
        end

        it 'set Service defined parameters' do
          network = config.get_service(:network)
          network[:config][:content_type].must_equal :hash
          network[:config][:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Global Key' => 'Global Value', 'Local Key' => 'Local Value')
          network[:config][:interface].must_equal 'admin'
          network[:config][:region].must_equal 'region_local'
          network[:config][:ssl_verify_mode].must_equal true

          network[:config][:endpoint].must_equal 'https://service1.example.com:8888'
          network[:config][:service_name].must_equal 'service1'
          network[:config][:version].must_equal '2.10'
        end

        it 'set no Service defined parameters' do
          compute = config.get_service(:compute)
          compute[:config][:content_type].must_equal :json
          compute[:config][:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Global Key' => 'Global Value')
          compute[:config][:interface].must_equal 'internal'
          compute[:config][:region].must_equal 'region_global'
          compute[:config][:ssl_verify_mode].must_equal false

          compute[:config][:endpoint].must_equal nil
          compute[:config][:service_name].must_equal nil
          compute[:config][:version].must_equal nil
        end
      end
    end
  end
end
