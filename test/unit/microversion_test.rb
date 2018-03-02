require 'test_helper'
require 'auth_helper'
require 'misty/openstack/service'
require 'misty/microversion'
require 'misty/config'

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
          'version' => '2.25',
          'id' => 'v2.1' }] }
  end

  let(:microversion_service) do
    auther = Minitest::Mock.new

    def auther.get_url(*args)
      'http://localhost'
    end

    def auther.get_token
      'token_id'
    end

    stub_request(:get, 'http://localhost/').
      with(:headers => {'Accept'=>'application/json'}).
      to_return(:status => 200, :body => JSON.dump(versions_data), :headers => {})

    globals = Class.new do
      include Misty::Config

      attr_reader :config

      def initialize(args)
        @config = set_config({})
        @config[:auth] = args
      end
    end

    args = globals.new(auther)
    Misty::Openstack::Nova::V2_1.new(args.config)
  end

  describe '#version_get' do
    it 'returns the version number' do
      microversion_service.version_get('2.12').must_equal '2.12'
    end

    it 'returns the version number' do
      microversion_service.version_get('CURRENT').must_equal '2.25'
    end

    it 'fails when version is not within supporterd interval' do
      proc do
        microversion_service.version_get('2.0')
      end.must_raise Misty::Microversion::VersionError
    end

    it 'fails when LATEST version is not available' do
      proc do
        microversion_service.version_get('LATEST')
      end.must_raise Misty::Microversion::VersionError
    end

    it 'fails when using an invalid version State' do
      proc do
        microversion_service.version_get('OTHER')
      end.must_raise Misty::Microversion::VersionError
    end
  end
end
