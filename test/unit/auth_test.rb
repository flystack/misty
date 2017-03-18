require 'test_helper'
require 'auth_helper'

describe Misty::Auth do
  describe ".new" do
    let(:authv3_creds) do
      {
        :url      => "http://localhost:5000",
        :user     => "admin",
        :password => "secret",
        :project  => "admin",
        :domain   => "default"
      }
    end

    let(:authv2_creds) do
      {
        :url      => "http://localhost:5000",
        :user     => "admin",
        :password => "secret",
        :tenant   => "admin"
      }
    end

    describe Misty::AuthV3 do
      it "#new fails when missing credentials" do
        stub_request(:post, "http://localhost:5000/v3/auth/tokens").
          to_return(:status => 200, :body => "{\"token\":{\"catalog\":[]}}", :headers => {"x-subject-token"=>"token_data"})

        proc do
          Misty::AuthV3.new({}, false, Logger.new('/dev/null'))
        end.must_raise Misty::Auth::CredentialsError
      end

      it "#get_token" do
        stub_request(:post, "http://localhost:5000/v3/auth/tokens").
          to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {"x-subject-token"=>"token_data"})

        auth = Misty::AuthV3.new(authv3_creds, false, Logger.new('/dev/null'))
        auth.stub :expired?, false do
          auth.get_token.must_equal "token_data"
        end
      end

      it "#catalog" do
        stub_request(:post, "http://localhost:5000/v3/auth/tokens").
          to_return(:status => 200, :body => "{\"token\":{\"catalog\":[\"catalog_data\"]}}", :headers => {"x-subject-token"=>"token_data"})

        auth = Misty::AuthV3.new(authv3_creds, false, Logger.new('/dev/null'))
        auth.catalog.must_equal ["catalog_data"]
      end

      it "#get_endpoint" do
        stub_request(:post, "http://localhost:5000/v3/auth/tokens").
          to_return(:status => 200, :body => JSON.dump(auth_response_v3("identity", "keystone")), :headers => {"x-subject-token"=>"token_data"})

        auth = Misty::AuthV3.new(authv3_creds, false, Logger.new('/dev/null'))
        auth.get_endpoint(%w{identity}, "regionOne", "public").must_equal "http://localhost"
      end
    end

    describe Misty::AuthV2 do
      it "#new fails when missing credentials" do
        stub_request(:post, "http://localhost:5000/v2.0/tokens").
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"}}}", :headers => {})

        proc do
          Misty::AuthV2.new({}, false, Logger.new('/dev/null'))
        end.must_raise Misty::Auth::CredentialsError
      end

      it "#get_token" do
        stub_request(:post, "http://localhost:5000/v2.0/tokens").
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

        auth = Misty::AuthV2.new(authv2_creds, false, Logger.new('/dev/null'))
        auth.stub :expired?, false do
          auth.get_token.must_equal "token_data"
        end
      end

      it "#catalog" do
        stub_request(:post, "http://localhost:5000/v2.0/tokens").
          to_return(:status => 200, :body => "{\"access\":{\"token\":{\"id\":\"token_data\"},\"serviceCatalog\":[\"catalog_data\"]}}", :headers => {})

        auth = Misty::AuthV2.new(authv2_creds, false, Logger.new('/dev/null'))
        auth.catalog.must_equal ["catalog_data"]
      end

      it "#get_endpoint" do
        stub_request(:post, "http://localhost:5000/v2.0/tokens").
          to_return(:status => 200, :body => JSON.dump(auth_response_v2("identity", "keystone")), :headers => {"x-subject-token"=>"token_data"})

        auth = Misty::AuthV2.new(authv2_creds, false, Logger.new('/dev/null'))
        auth.get_endpoint(%w{identity}, "regionOne", "public").must_equal "http://localhost"
      end
    end
  end
end
