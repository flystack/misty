require 'test_helper'

describe 'Services' do
  describe '#add' do
    it 'Adds a service' do
      services = Misty::Services.new
      services.add(type: :service_type, project: :project_name, versions: ['v1', 'v2.0'], microversion: 'v2.12')
      service = services.services[0]

      services.services.size.must_equal 1
      service.must_be_kind_of Misty::Service
      service.type.must_equal :service_type
      service.project.must_equal :project_name
      service.versions.must_include 'v1'
      service.microversion.must_equal 'v2.12'
      service.default_version.must_equal 'v2.0'
      services.to_s.must_equal %Q(service_type: project_name, versions: ["v1", "v2.0"], microversion: v2.12\n)
    end
  end
end
