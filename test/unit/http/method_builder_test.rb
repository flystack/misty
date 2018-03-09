require 'test_helper'
require 'misty/http/method_builder'

describe Misty::HTTP::MethodBuilder do
  let(:service) do
    service = Object.new
    service.extend(Misty::HTTP::MethodBuilder)

    def service.base_path=(val)
      @base_path = val
    end

    service
  end

  describe '#base_filter' do
    it 'return path with base_path' do
      service.base_path = '/base_path'
      service.send(:base_filter, true, '/abc/def/').must_equal '/base_path/abc/def/'
    end

    it 'returns path only' do
      service.base_path = '/base_path'
      service.send(:base_filter, false, '/abc/def/').must_equal '/abc/def/'
    end
  end

  describe '#count_path_params' do
    it 'returns number of path parameters from path' do
      service.send(:count_path_params, '/servers/{element1}/config/{element2}/{element3}').must_equal 3
    end

    it 'returns 0 when no parameters in path' do
      service.send(:count_path_params, '/blah/bla').must_equal 0
    end
  end

  describe '#get_method' do
    before do
      def service.api
        {
          '/' => { GET: [:list_api_versions] },
          '/v2.0/' => { GET: [:show_api_v2_details] },
          '/v2.0/extensions' => { GET: [:list_extensions] },
          '/v2.0/extensions/{alias}' => { GET: [:show_extension_details] },
          '/v2.0/networks/{network_id}' => { GET: [:show_network_details], PUT: [:update_network], DELETE: [:delete_network] }
        }
      end
    end

    it 'successful find a existing method' do
      service.send(:get_method, :list_extensions).must_equal ({:path=>'/v2.0/extensions', :request=>:GET, :name=>:list_extensions})
    end

    it 'returns nil when no method matches' do
      service.send(:get_method, :incognito).must_be_nil
    end
  end

  describe '#inject_elements' do
    let(:path) { '/v3/domains/{domain_id}/groups/{group_id}/roles/{role_id}/projects' }

    it 'replaces elements' do
      service.send(:inject_elements, path, ['id1', 'id2', 'id3']).must_equal '/v3/domains/id1/groups/id2/roles/id3/projects'
    end

    it 'fails when not enough arguments' do
      proc do
        service.send(:inject_elements, path, 'id1', 'id2')
      end.must_raise ArgumentError
    end

    it 'return path when no match' do
      service.send(:inject_elements, '/v3/path', ['id1', 'id2']).must_equal '/v3/path'
    end
  end

  describe '#prefixed_path' do
    it 'returns true and same path with empty prefix' do
      def service.prefix_path_to_ignore
        ''
      end

      path = '/v3/resources/type'
      base, newpath = service.send(:prefixed_path, path)
      base.must_equal true
      newpath.must_equal path
    end

    it 'returns false and same path when unmatched prefix' do
      def service.prefix_path_to_ignore
        '/v3/{project_id}'
      end

      path = '/v2/schemas/tasks'
      base, newpath = service.send(:prefixed_path, path)
      base.must_equal false
      newpath.must_equal path
    end

    it 'returns true and filtered path when matched prefix' do
      def service.prefix_path_to_ignore
        '/v3/{project_id}'
      end

      path = '/v3/{project_id}/backups/detail'
      base, newpath = service.send(:prefixed_path, path)
      base.must_equal true
      newpath.must_equal '/backups/detail'
    end
  end

  describe '#query_param' do
    it 'returns string when passing a String' do
      service.send(:query_param, 'name=foobar').must_equal '?name=foobar'
    end

    it 'returns empty string when passing an empty String' do
      service.send(:query_param, '').must_equal ''
    end

    it 'returns a query string when passing in a Hash' do
      service.send(:query_param, {}).must_equal ''
      service.send(:query_param, {:foo  => 'bar'}).must_equal '?foo=bar'
      service.send(:query_param, {'foo' => 'bar'}).must_equal '?foo=bar'
      service.send(:query_param, {:foo => ['bar', 'baz'], :value => 42, :flag => nil }).must_equal '?foo=bar&foo=baz&value=42&flag'
      service.send(:query_param, {'===' => 'Ëncøding is hárd!'}).must_equal '?%3D%3D%3D=%C3%8Bnc%C3%B8ding+is+h%C3%A1rd%21'
    end

    it 'returns nil unless passing a String or Hash' do
      service.send(:query_param, 42).must_be_nil
    end
  end
end
