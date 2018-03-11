require 'test_helper'

describe Misty::Auth::Catalog::V3 do
  let(:payload) do
    [{'endpoints' => [
        {'region_id' => 'regionOne',
         'url'       => 'http://localhost:8080/v1',
         'region'    => 'regionOne',
         'interface' => 'internal',
         'id'        => 'id_endpoint1_internal'},
        {'region_id' => 'regionOne',
          'url'       => 'http://localhost:8081/v1',
          'region'    => 'regionOne',
          'interface' => 'public',
          'id'        => 'id_endpoint1_public' },
         {'region_id' => 'regionOne',
          'url'       => 'http://localhost:8082/v1',
          'region'    => 'regionOne',
          'interface' => 'admin',
          'id'        => 'id_endpoint1_admin' }],
      'type'      => 'v3_service1',
      'id'        => 'id_endpoint1',
      'name'      => 'alias1' }]
  end

  describe '#new' do
    it 'successful' do
      catalog = Misty::Auth::Catalog::V3.new(payload)
      catalog.get_endpoint_url('v3_service1', 'regionOne', 'admin').must_equal 'http://localhost:8082/v1'
    end
  end

  describe 'fails' do
    it 'with unmatched service type' do
      catalog = Misty::Auth::Catalog::V3.new(payload)
      proc do
        catalog.get_endpoint_url('service', 'regionOther', 'nadmin')
        end.must_raise Misty::Auth::Catalog::ServiceTypeError
    end

    it 'with unmatched region' do
      catalog = Misty::Auth::Catalog::V3.new(payload)
      proc do
        catalog.get_endpoint_url('v3_service1', 'regionOther', 'admin')
      end.must_raise Misty::Auth::Catalog::EndpointError
    end

    it 'with unmatched interface' do
      catalog = Misty::Auth::Catalog::V3.new(payload)
      proc do
        catalog.get_endpoint_url('v3_service1', 'regionOne', 'private')
      end.must_raise Misty::Auth::Catalog::EndpointError
    end
  end
end

describe Misty::Auth::Catalog::V2 do
  let(:payload) do
    [{ 'endpoints' =>
      [{ 'adminURL' => 'http://localhost',
        'region' => 'regionTwo',
        'internalURL' => 'http://localhost:8888/v2.0',
        'id' => 'id_endpoints',
        'publicURL' => 'http://localhost' }],
        'endpoints_links' => [],
        'type' => 'v2_service1',
        'name' => 'aliasv2' }]
  end

  describe '#new' do
    it 'success' do
      catalog = Misty::Auth::Catalog::V2.new(payload)
      catalog.get_endpoint_url('v2_service1', 'regionTwo', 'internal').must_equal 'http://localhost:8888/v2.0'
    end

    describe 'fails' do
      it 'with unmatched arguments' do
        catalog = Misty::Auth::Catalog::V2.new(payload)
        proc do
          catalog.get_endpoint_url('test', 'regionOther', 'nadmin')
        end.must_raise Misty::Auth::Catalog::ServiceTypeError
      end

      it 'with unmatched region' do
        catalog = Misty::Auth::Catalog::V2.new(payload)
        proc do
          catalog.get_endpoint_url('v2_service1','regionOther', 'admin')
        end.must_raise Misty::Auth::Catalog::EndpointError
      end

      it 'with unmatched interface' do
        catalog = Misty::Auth::Catalog::V2.new(payload)
        proc do
          catalog.get_endpoint_url('v2_service1','regionTwo', 'private')
        end.must_raise Misty::Auth::Catalog::EndpointError
      end
    end
  end
end
