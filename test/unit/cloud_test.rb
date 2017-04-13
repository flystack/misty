require 'test_helper'
require 'service_helper'
require 'auth_helper'

describe "#dot_to_underscore" do
  it "returns a valid name" do
    name = Misty::Cloud.dot_to_underscore("v20.90.01")
    name.must_equal "v20_90_01"
  end
end

describe Misty::Cloud do
  describe "A service" do
    let(:auth) do
      stub_request(:post, "http://localhost:5000/v3/auth/tokens").
        with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"name\":\"admin\",\"domain\":{\"id\":\"default\"},\"password\":\"secret\"}}},\"scope\":{\"project\":{\"name\":\"admin\",\"domain\":{\"id\":\"default\"}}}}}",
        :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => JSON.dump(auth_response_v3("identity", "keystone")), :headers => {"x-subject-token"=>"token_data"})

      auth = {
        :url      => "http://localhost:5000",
        :user     => "admin",
        :password => "secret",
        :project  => "admin",
      }
    end

    it "uses default version" do
      cloud = Misty::Cloud.new(:auth => auth)
      cloud.services[:identity].must_equal ({:keystone => "v3"})
    end

    it "uses provided version" do
      cloud = Misty::Cloud.new(:auth => auth, :identity => {:api_version => "v2.0"})
      cloud.services[:identity].must_equal ({:keystone => "v2.0"})
    end

    it "uses default version when provided version is out of range" do
      cloud = Misty::Cloud.new(:auth => auth, :identity => {:api_version => "v1"})
      cloud.services[:identity].must_equal ({:keystone => "v3"})
    end
  end

  describe "All SERVICES" do
    it "have a method defined" do
      Misty::SERVICES.each do |service|
        method =  Misty::Cloud.method_defined?(service.name)
        method.must_equal true
      end
    end
  end

  describe "#setup" do
    it "sets up default values" do
      Misty::Auth.stub :factory, nil do
        setup = Misty::Cloud.setup({})
        setup.must_be_kind_of Misty::Cloud::Setup
        setup.content_type.must_equal Misty::CONTENT_TYPE
        setup.log.must_be_kind_of Logger
        setup.interface.must_equal Misty::INTERFACE
        setup.proxy.must_be_kind_of URI
        setup.proxy.host.must_be_nil
        setup.region_id.must_equal Misty::REGION_ID
        setup.ssl_verify_mode.must_equal Misty::SSL_VERIFY_MODE
      end
    end
  end

  describe "#new" do
    describe "fails" do
      it "when no credentials" do
        proc do
          Misty::Cloud.new
        end.must_raise Misty::Auth::CredentialsError
      end

      it "with empty credentials" do
        proc do
          Misty::Cloud.new(:auth => {})
        end.must_raise Misty::Auth::CredentialsError
      end

      it "with incomplete credentials" do
        proc do
          Misty::Cloud.new(:auth => {:user => "user", :url => "http://localhost" })
        end.must_raise Misty::Auth::CredentialsError
      end

      it "without url" do
        authv3_data = {
          :user     => "admin",
          :password => "secret",
          :project  => "admin"
        }

        proc do
          Misty::Cloud.new(:auth => authv3_data)
        end.must_raise Misty::Auth::URLError
      end

      it "with empty url" do
        authv3_data = {
          :url      => "",
          :user     => "admin",
          :password => "secret",
          :project  => "admin"
        }

        proc do
          Misty::Cloud.new(:auth => authv3_data)
        end.must_raise Misty::Auth::URLError
      end
    end

    describe "Authenticates" do
      describe "with v2 credentials" do
        let(:authv2_data) do
          {
            :url      => "http://localhost:5000",
            :user     => "admin",
            :password => "secret",
            :tenant   => "admin"
          }
        end

        it "uses AuthV2" do
          authv2 = Minitest::Mock.new

          Misty::AuthV2.stub :new, authv2 do
            cloud = Misty::Cloud.new(:auth => authv2_data)
            authv2.verify
          end
        end
      end

      describe "with v3 credentials" do
        let(:authv3_data) do
          {
            :url      => "http://localhost:5000",
            :user     => "admin",
            :password => "secret",
            :project  => "admin"
          }
        end

        it "uses AuthV3" do
          authv3 = Minitest::Mock.new

          Misty::AuthV3.stub :new, authv3 do
            cloud = Misty::Cloud.new(:auth => authv3_data)
            authv3.verify
          end
        end
      end
    end
  end
end
