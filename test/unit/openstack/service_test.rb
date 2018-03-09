require 'test_helper'
require 'service_helper'
require 'misty/openstack/service'

describe Misty::Openstack::Service do
  describe '#prefix_path_to_ignore' do
    let(:service) do
      service = Object.new
      service.extend(Misty::Openstack::Service)
      service
    end

    it "returns empty String when undefined in API's module" do
      service.prefix_path_to_ignore.must_be_empty
    end

    it "returns String when defined in API's module" do
      def service.prefix_path_to_ignore
        '/v3/{tenant_id}'
      end

      service.prefix_path_to_ignore.must_equal '/v3/{tenant_id}'
    end
  end

  describe '#requests' do
    it 'returns list of requests' do
      list = service.requests
      list.must_be_kind_of Array
      list.must_include :list_service_profiles
    end
  end

  describe 'headers' do
    it 'returns default global along with token' do
      service.headers.get.must_equal ({"Accept"=>"application/json; q=1.0"})
    end

    it 'inject headers parameter' do
      service(content_type = :hash, params = {:headers => {'Oh' => 'my!'}}).
        headers.get.must_equal ({"Accept"=>"application/json; q=1.0", "Oh"=>"my!"})
    end
  end
end
