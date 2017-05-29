require 'test_helper'

describe "Services" do
  describe "#add" do
    it "Adds a service" do
      services = Misty::Services.new
      services.add(:name, :project, ["v1", "v2.0"])
      services.services.size.must_equal 1
      service = services.services[0]
      service.must_be_kind_of Misty::Services::Service
      service.name.must_equal :name
      service.project.must_equal :project
      service.versions.must_include "v1"
      services.to_s.must_equal %Q{name: project: ["v1", "v2.0"]\n}
    end
  end
end
