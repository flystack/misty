require 'test_helper'
require 'misty/config'

describe Misty::Config do
  let(:service_klass) do
    Class.new do
      include Misty::Config

      attr_reader :config

      def initialize(args)
        @config = set_config(args)
      end
    end
  end

  it 'create with default values' do
    service = service_klass.new({})
    service.config[:content_type].must_equal Misty::Config::CONTENT_TYPE
    service.config[:headers].must_be_kind_of Misty::HTTP::Header
    service.config[:headers].get.must_equal("Accept"=>"application/json; q=1.0")
    service.config[:interface].must_equal Misty::Config::INTERFACE
    service.config[:region_id].must_equal Misty::Config::REGION_ID
    service.config[:ssl_verify_mode].must_equal Misty::Config::SSL_VERIFY_MODE
    service.config[:log].must_be_kind_of Logger
  end

  it 'create with parameters' do
    service = service_klass.new(
      :content_type    => :json,
      :headers         => {'var' => 'value'},
      :interface       => 'admin',
      :region_id       => 'regionTest',
      :ssl_verify_mode => false,
      :log_file        => './test.log'
    )
    service.config[:content_type].must_equal :json
    service.config[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'var' => 'value')
    service.config[:interface].must_equal 'admin'
    service.config[:region_id].must_equal 'regionTest'
    service.config[:ssl_verify_mode].must_equal false
  end

  it 'create fails with wrong header type' do
    proc do
      service_klass.new(:headers => :blah)
    end.must_raise Misty::HTTP::Header::TypeError
  end

  it 'create fails with invalid interface' do
    proc do
      service_klass.new(:interface => 'something')
    end.must_raise Misty::Config::InvalidDataError
  end

  it 'create fails unless region id is String type' do
    proc do
      service_klass.new(:region_id => true)
    end.must_raise Misty::Config::InvalidDataError
  end

  it 'fails unless ssl_verify_mode is a boolean' do
    proc do
      service_klass.new(:ssl_verify_mode => 'something')
    end.must_raise Misty::Config::InvalidDataError
  end

  describe 'create locals' do
    let(:service_klass) do
      Class.new do
        include Misty::Config

        attr_reader :locals

        def initialize(global_params, local_params)

          globals = set_config(global_params)
          @locals = set_config(local_params, globals)
        end
      end
    end

    it 'with globals defaults' do
      globals = {}

      new_values = {
        :content_type    => :json,
        :headers         => {'Key1' => 'Value1'},
        :interface       => 'internal',
        :region_id       => 'region_local',
        :ssl_verify_mode => false
      }

      service = service_klass.new(globals, new_values)
      service.locals[:content_type].must_equal :json
      service.locals[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Key1' => 'Value1')
      service.locals[:interface].must_equal 'internal'
      service.locals[:region_id].must_equal 'region_local'
      service.locals[:ssl_verify_mode].must_equal false
    end

    it 'with globals parameters' do
      globals = {
        :content_type    => :json,
        :headers         => {'Key2' => 'Value2'},
        :interface       => 'internal',
        :region_id       => 'region_global',
        :ssl_verify_mode => false
      }

      new_values = {
        :content_type    => :ruby,
        :headers         => {'Key2' => 'Value2'},
        :interface       => 'admin',
        :region_id       => 'region_local',
        :ssl_verify_mode => true
      }

      service = service_klass.new(globals, new_values)
      service.locals[:content_type].must_equal :ruby
      service.locals[:headers].get.must_equal('Accept' => 'application/json; q=1.0', 'Key2' => 'Value2')
      service.locals[:interface].must_equal 'admin'
      service.locals[:region_id].must_equal 'region_local'
      service.locals[:ssl_verify_mode].must_equal true
    end
  end
end
