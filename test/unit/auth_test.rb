require 'test_helper'
require 'auth_helper'

describe Misty::Auth do
  let(:config) do
    Misty::Cloud::Config.new
  end

  describe Misty::AuthV3 do
    describe '#new' do
      it 'fails when missing credentials' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => "{\"token\":{\"catalog\":[]}}", :headers => {'x-subject-token'=>'token_data'})

        proc do
          Misty::AuthV3.new({}, config)
        end.must_raise Misty::Auth::URLError
      end

      describe 'using the password method' do
        describe 'with a project scope' do
          it 'authenticates using a project id' do
            auth = {
              :url        => 'http://localhost:5000',
              :user_id    => 'user_id',
              :password   => 'secret',
              :project_id => 'project_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end

          it 'authenticates using a project name and a project domain id' do
            auth = {
              :url               => 'http://localhost:5000',
              :user_id           => 'user_id',
              :password          => 'secret',
              :project           => 'project',
              :project_domain_id => 'domain_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"name\":\"project\",\"domain\":{\"id\":\"domain_id\"}}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end
        end

        describe 'with a domain scope' do
          it 'authenticates using a domain id' do
            auth = {
              :url       => 'http://localhost:5000',
              :user_id   => 'user_id',
              :password  => 'secret',
              :domain_id => 'domain_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"domain\":{\"id\":\"domain_id\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end

          it 'authenticates using a domain name' do
            auth = {
              :url      => 'http://localhost:5000',
              :user_id  => 'user_id',
              :password => 'secret',
              :domain   => 'domain'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"domain\":{\"name\":\"domain\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end
        end
      end

      describe 'using the token method' do
        describe 'with a project scope' do
          it 'authenticates using a project id' do
            auth = {
              :url        => 'http://localhost:5000',
              :token      => 'token',
              :project_id => 'project_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"token\"],\"token\":{\"id\":\"token\"}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end

          it 'authenticates using a project name and a project domain id' do
            auth = {
              :url               => 'http://localhost:5000',
              :token             => 'token',
              :project           => 'project',
              :project_domain_id => 'domain_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"token\"],\"token\":{\"id\":\"token\"}},\"scope\":{\"project\":{\"name\":\"project\",\"domain\":{\"id\":\"domain_id\"}}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end
        end

        describe 'with a domain scope' do
          it 'authenticates using a domain id' do
            auth = {
              :url       => 'http://localhost:5000',
              :token     => 'token',
              :domain_id => 'domain_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"token\"],\"token\":{\"id\":\"token\"}},\"scope\":{\"domain\":{\"id\":\"domain_id\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end

          it 'authenticates using a domain name' do
            auth = {
              :url    => 'http://localhost:5000',
              :token  => 'token',
              :domain => 'domain'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"token\"],\"token\":{\"id\":\"token\"}},\"scope\":{\"domain\":{\"name\":\"domain\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            Misty::AuthV3.new(auth, config)
          end
        end
      end
    end

    describe 'when authenticated' do
      let(:authv3_creds) do
        {
          :url              => 'http://localhost:5000',
          :user             => 'admin',
          :password         => 'secret',
          :project          => 'admin',
          :project_domain_id=> 'default'
        }
      end

      it '#get_token' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {'x-subject-token'=>'token_data'})

        auth = Misty::AuthV3.new(authv3_creds, config)
        auth.stub :expired?, false do
          auth.get_token.must_equal 'token_data'
        end
      end

      it '#catalog' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {'x-subject-token'=>'token_data'})

        auth = Misty::AuthV3.new(authv3_creds, config)
        auth.catalog.must_equal ['catalog_data']
      end

      it '#get_endpoint' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3("identity", "keystone")), :headers => {'x-subject-token'=>'token_data'})

        auth = Misty::AuthV3.new(authv3_creds, config)
        auth.get_endpoint(%w{identity}, 'regionOne', 'public').must_equal 'http://localhost'
      end
    end
  end

  describe Misty::AuthV2 do
    describe '#new' do
      it 'fails when missing credentials' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"}}}", :headers => {})

        proc do
          Misty::AuthV2.new({}, config)
        end.must_raise Misty::Auth::URLError
      end

      describe 'using the password method' do
        it 'authenticates using the tenant name' do
          auth = {
            :url      => 'http://localhost:5000',
            :user     => 'user',
            :password => 'secret',
            :tenant   => 'tenant',
          }

          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            with(:body => "{\"auth\":{\"passwordCredentials\":{\"username\":\"user\",\"password\":\"secret\"},\"tenantName\":\"tenant\"}}").
            to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {})

          Misty::AuthV2.new(auth, config)
        end

        it 'authenticates using the tenant id' do
          auth = {
            :url       => 'http://localhost:5000',
            :user      => 'user',
            :password  => 'secret',
            :tenant_id => 'tenant_id',
          }

          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            with(:body => "{\"auth\":{\"passwordCredentials\":{\"username\":\"user\",\"password\":\"secret\"},\"tenantId\":\"tenant_id\"}}").
            to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {})

          Misty::AuthV2.new(auth, config)
        end
      end

      describe 'using the token method' do
        it 'authenticates using the tenant name' do
          auth = {
            :url    => 'http://localhost:5000',
            :token  => 'token_id',
            :tenant => 'tenant',
          }

          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            with(:body => "{\"auth\":{\"token\":{\"id\":\"token_id\"},\"tenantName\":\"tenant\"}}").
            to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {})

          Misty::AuthV2.new(auth, config)
        end

        it 'authenticates using the tenant id' do
          auth = {
            :url       => 'http://localhost:5000',
            :token     => 'token_id',
            :tenant_id => 'tenant_id',
          }

          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            with(:body => "{\"auth\":{\"token\":{\"id\":\"token_id\"},\"tenantId\":\"tenant_id\"}}").
            to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {})

          Misty::AuthV2.new(auth, config)
        end
      end
    end

    describe 'when authenticated' do
      let(:authv2_creds) do
        {
          :url      => 'http://localhost:5000',
          :user     => 'admin',
          :password => 'secret',
          :tenant   => 'admin'
        }
      end

      it '#get_token' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

        auth = Misty::AuthV2.new(authv2_creds, config)
        auth.stub :expired?, false do
          auth.get_token.must_equal 'token_data'
        end
      end

      it '#catalog' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

        auth = Misty::AuthV2.new(authv2_creds, config)
        auth.catalog.must_equal ['catalog_data']
      end

      it '#get_endpoint' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

        auth = Misty::AuthV2.new(authv2_creds, config)
        auth.get_endpoint(%w{identity}, 'regionOne', 'public').must_equal 'http://localhost'
      end
    end
  end
end
