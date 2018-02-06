require 'test_helper'
require 'service_helper'
require 'misty/client'

describe Misty::Client do
  describe '#prefix_path_to_ignore' do
    let(:client) do
      client = Object.new
      client.extend(Misty::Client)
      client
    end

    it "returns empty String when undefined in API's module" do
      client.prefix_path_to_ignore.must_be_empty
    end

    it "returns String when defined in API's module" do
      class << client
        def prefix_path_to_ignore
          '/v3/{tenant_id}'
        end
      end

      client.prefix_path_to_ignore.must_equal '/v3/{tenant_id}'
    end
  end

  describe '#requests' do
    it 'returns list of requests' do
      list = service.requests
      list.must_be_kind_of Array
      list.must_include :list_service_profiles
    end
  end

  describe '#baseclass' do
    it 'returns base class name' do
      service.send(:baseclass).must_equal 'V2_0'
    end
  end

  describe '#setup' do
    it 'use default options' do
      options = service.send(:setup, {})
      options.must_be_kind_of Misty::Client::Options
      options.base_path.must_be_nil
      options.base_url.must_be_nil
      options.headers.must_equal ({})
      options.interface.must_equal 'public'
      options.region_id.must_equal 'regionOne'
      options.service_names.must_include 'network'
      options.ssl_verify_mode.must_equal true
      options.version.must_equal 'CURRENT'
    end

    it 'use custom options' do
      options = service.send(:setup, {
        :base_path       => '/test_path',
        :base_url        => 'test_url',
        :headers         => {'Key 1' => 'Value 1'},
        :region_id       => 'regionTwo',
        :interface       => 'internal',
        :ssl_verify_mode => false,
        :version         => 'LATEST'})
      options.base_path.must_equal '/test_path'
      options.base_url.must_equal 'test_url'
      options.headers.must_equal ({'Key 1' => 'Value 1'})
      options.interface.must_equal 'internal'
      options.region_id.must_equal 'regionTwo'
      options.ssl_verify_mode.must_equal false
      options.version.must_equal 'LATEST'
    end

    it 'fails with invalid interface' do
      proc do
        service.send(:setup, {:interface => 'something'})
      end.must_raise Misty::Client::InvalidDataError
    end

    it 'fails unless ssl_verify_mode is a boolean' do
      proc do
        service.send(:setup, {:ssl_verify_mode => 'something'})
      end.must_raise Misty::Client::InvalidDataError
    end
  end

  describe 'headers' do
    it 'returns default global along with token' do
      service.headers.get.must_equal ({"Accept"=>"application/json; q=1.0"})
    end

    it 'inject headers parameter' do
      service(content_type = :ruby, params = {:headers => {'Oh' => 'my!'}}).
        headers.get.must_equal ({"Accept"=>"application/json; q=1.0", "Oh"=>"my!"})
    end
  end
end
