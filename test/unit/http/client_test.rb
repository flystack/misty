require 'test_helper'
require 'service_helper'
require 'misty/http/client'

describe Misty::HTTP::Client do
  describe "#self.prefix_path_to_ignore" do
    it "returns empty String when undefined in API's module" do
      Misty::Openstack::Neutron::V2_0::prefix_path_to_ignore.must_be_empty
    end

    it "returns String when defined in API's module" do
      Misty::Openstack::Cinder::V3.prefix_path_to_ignore.must_equal "/v3/{tenant_id}"
    end
  end

  describe "#requests" do
    it "returns list of requests" do
      list = service.requests
      list.must_be_kind_of Array
      list.must_include :list_service_profiles
    end
  end

  describe "#headers_default" do
    it "returns hash" do
      service.headers_default.must_be_kind_of Hash
    end
  end

  describe "#headers" do
    it "returns hash" do
      service.headers.must_be_kind_of Hash
    end
  end

  describe "#baseclass" do
    it "returns base class name" do
      service.send(:baseclass).must_equal "V2_0"
    end
  end

  describe "#net_http" do
    it "returns a Net/http instance" do
      endpoint = URI.parse("http://localhost")
      Misty::HTTP::NetHTTP.net_http(endpoint, false, Logger.new("/dev/null")).must_be_instance_of Net::HTTP
    end
  end

  describe "#setup" do
    it "sets default options" do
      options = service.send(:setup, {})
      options.must_be_kind_of Misty::HTTP::Client::Options
      options.base_path.must_be_nil
      options.base_url.must_be_nil
      options.interface.must_equal "public"
      options.region_id.must_equal "regionOne"
      options.service_names.must_include "network"
      options.ssl_verify_mode.must_equal true
      options.version.must_equal "CURRENT"
    end

    it "fails with invalid interface" do
      proc do
        service.send(:setup, {:interface => "something"})
      end.must_raise Misty::HTTP::Client::InvalidDataError
    end

    it "fails unless ssl_verify_mode is a boolean" do
      proc do
        service.send(:setup, {:ssl_verify_mode => "something"})
      end.must_raise Misty::HTTP::Client::InvalidDataError
    end
  end
end
