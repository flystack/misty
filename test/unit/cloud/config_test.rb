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

      it 'with region_id wrong type' do
        auth_request
        proc do
          Misty::Config.new(:auth => auth, :region_id => true)
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
        config.auth.must_be_kind_of Misty::AuthV3
        config.globals[:content_type].must_equal Misty::Config::CONTENT_TYPE
        config.globals[:headers].must_be_kind_of Misty::HTTP::Header
        config.globals[:headers].get.must_equal("Accept"=>"application/json; q=1.0")
        config.globals[:interface].must_equal Misty::Config::INTERFACE
        config.globals[:region_id].must_equal Misty::Config::REGION_ID
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
          :region_id       => 'regionTest',
          :ssl_verify_mode => false,
          :log_file        => LOG_FILE_NAME
        )
        def config.globals
          @globals
        end

        config.globals[:content_type].must_equal :json
        config.globals[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'var' => 'value')
        config.globals[:interface].must_equal 'admin'
        config.globals[:region_id].must_equal 'regionTest'
        config.globals[:ssl_verify_mode].must_equal false
        File.exist?(LOG_FILE_NAME).must_equal true
        File.delete(LOG_FILE_NAME) if File.exist?(LOG_FILE_NAME)
      end

      describe 'service level configurations' do
        it 'with globals defaults' do
          auth_request
          config = Misty::Config.new(
            :auth       => auth,
            :compute    => {
              :content_type    => :json,
              :headers         => {'Service Key' => 'Service Value'},
              :interface       => 'internal',
              :region_id       => 'region local',
              :ssl_verify_mode => false,

              :base_path       => 'base_path_test',
              :base_url        => '/base.url.com',
              :version         => 'vtest'
            }
          )

          service_config = config.get_service(:compute)
          service_config[:config][:content_type].must_equal :json
          service_config[:config][:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Service Key' => 'Service Value')
          service_config[:config][:interface].must_equal 'internal'
          service_config[:config][:region_id].must_equal 'region local'
          service_config[:config][:ssl_verify_mode].must_equal false
          service_config[:config][:base_path].must_equal 'base_path_test'
          service_config[:config][:base_url].must_equal '/base.url.com'
          service_config[:config][:version].must_equal 'vtest'
        end

        it 'with Cloud level parameters' do
          auth_request
          config = Misty::Config.new(
            :auth            => auth,
            :content_type    => :json,
            :headers         => {'Global Key' => 'Global Value'},
            :interface       => 'internal',
            :region_id       => 'region_global',
            :ssl_verify_mode => false,
              :networking => {
                :content_type    => :hash,
                :headers         => {'Local Key' => 'Local Value'},
                :interface       => 'admin',
                :region_id       => 'region_local',
                :ssl_verify_mode => true
              }
          )
          def config.globals
            @globals
          end

          service_config = config.get_service(:networking)
          service_config[:config][:content_type].must_equal :hash
          service_config[:config][:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Global Key' => 'Global Value', 'Local Key' => 'Local Value')
          service_config[:config][:interface].must_equal 'admin'
          service_config[:config][:region_id].must_equal 'region_local'
          service_config[:config][:ssl_verify_mode].must_equal true
        end
      end
    end
  end
end
