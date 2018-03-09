require 'test_helper'
require 'auth_helper'

describe Misty::Auth::Token do
  describe 'V3' do
    describe '#new' do
      it 'fails when missing credentials' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => "{\"token\":{\"catalog\":[]}}", :headers => {'x-subject-token'=>'token_data'})
        proc do
          token = Misty::Auth::Token.build({})
        end.must_raise Misty::Auth::Token::URLError
      end

      describe 'using the password method' do
        describe 'with a project scope' do
          it 'authenticates using a project id' do
            auth = {
              :url             => 'http://localhost:5000',
              :user_id         => 'user_id',
              :password        => 'secret',
              :project_id      => 'project_id',
              :ssl_verify_mode => false
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"id\":\"project_id\"}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data_v3'})

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data_v3'
          end

          it 'authenticates using a project name and a project domain id' do
            auth = {
              :url               => 'http://localhost:5000',
              :user_id           => 'user_id',
              :password          => 'secret',
              :project           => 'project',
              :project_domain_id => 'project_domain_id'
            }

            stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"id\":\"user_id\",\"password\":\"secret\"}}},\"scope\":{\"project\":{\"name\":\"project\",\"domain\":{\"id\":\"project_domain_id\"}}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})
            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
          end

          it 'authenticates using a project name and a project domain name' do
            auth = {
              :url               => 'http://localhost:5000',
              :user              => 'user',
              :user_domain       => 'user_domain',
              :password          => 'secret',
              :project           => 'project',
              :project_domain    => 'project_domain'
            }

            stub_request(:post, "http://localhost:5000/v3/auth/tokens").
              with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"name\":\"user\",\"domain\":{\"name\":\"user_domain\"},\"password\":\"secret\"}}},\"scope\":{\"project\":{\"name\":\"project\",\"domain\":{\"name\":\"project_domain\"}}}}}").
              to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

            token = Misty::Auth::Token.build(auth)
            token.get.must_equal 'token_data'
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

      describe '#get' do
        it 'when token has not expired' do
          stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
          to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {'x-subject-token'=>'token_data'})

          token = Misty::Auth::Token.build(authv3_creds)
          token.stub :expired?, false do
            token.get.must_equal 'token_data'
          end
        end

        it 'when token has expired' do
          stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
          to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {'x-subject-token'=>'token_data'})

          token = Misty::Auth::Token.build(authv3_creds)
          token.stub :expired?, true do
            token.get.must_equal 'token_data'
          end
        end
      end

      it '#catalog' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {'x-subject-token'=>'token_data'})

        token = Misty::Auth::Token.build(authv3_creds)
        token.catalog.payload.must_equal ['catalog_data']
      end

      it '#get_endpoint_url' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3("identity", "keystone")), :headers => {'x-subject-token'=>'token_data'})

        token = Misty::Auth::Token.build(authv3_creds)
        token.catalog.get_endpoint_url(%w(identity), 'regionOne', 'public').must_equal 'http://localhost'
      end
    end
  end

  describe 'V2' do
    describe '#new' do
      it 'fails when missing credentials' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"}}}", :headers => {})

        proc do
          Misty::Auth::Token.build({})
        end.must_raise Misty::Auth::Token::URLError
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

          token = Misty::Auth::Token.build(auth)
          token.get.must_equal '4ae647d3a5294690a3c29bc658e17e26'
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

          token = Misty::Auth::Token.build(auth)
          token.get.must_equal '4ae647d3a5294690a3c29bc658e17e26'
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

          token = Misty::Auth::Token.build(auth)
          token.get.must_equal '4ae647d3a5294690a3c29bc658e17e26'
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

          token = Misty::Auth::Token.build(auth)
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

      describe '#get' do
        it 'when token has not expired' do
          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_not_expired\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

          token = Misty::Auth::Token.build(authv2_creds)
          token.stub :expired?, false do
            token.get.must_equal 'token_not_expired'
          end
        end

        it 'when token has expired' do
          stub_request(:post, 'http://localhost:5000/v2.0/tokens').
            to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_expired\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

          token = Misty::Auth::Token.build(authv2_creds)
          token.stub :expired?, true do
            token.get.must_equal 'token_expired'
          end
        end
      end

      it '#catalog' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

        token = Misty::Auth::Token.build(authv2_creds)
        token.catalog.payload.must_equal ['catalog_data']
      end

      it '#get_endpoint_url' do
        stub_request(:post, 'http://localhost:5000/v2.0/tokens').
          to_return(:status => 200, :body => JSON.dump(auth_response_v2('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

        token = Misty::Auth::Token.build(authv2_creds)
        token.catalog.get_endpoint_url(%w(identity), 'regionOne', 'public').must_equal 'http://localhost'
      end
    end
  end
end
