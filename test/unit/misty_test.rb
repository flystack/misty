require 'test_helper'

def validate(service)
  service.must_be_kind_of Misty::Services::Service
  service.name.must_be_kind_of Symbol
  service.project.must_be_kind_of Symbol
  service.versions.must_be_kind_of Array
  service.versions.each do |version|
    version.must_be_kind_of String
  end
end

describe Misty do
  describe "#set_services" do
    it "has alarming service" do
      service = Misty::services.find { |s| s.name == :alarming}
      validate(service)
    end

    it "has baremetal service" do
      service = Misty::services.find { |s| s.name == :baremetal}
      validate(service)
    end

    it "has block_storage service" do
      service = Misty::services.find { |s| s.name == :block_storage}
      validate(service)
    end

    it "has clustering service" do
      service = Misty::services.find { |s| s.name == :clustering}
      validate(service)
    end

    it "has compute service" do
      service = Misty::services.find { |s| s.name == :compute}
      validate(service)
    end

    it "has container service" do
      service = Misty::services.find { |s| s.name == :container}
      validate(service)
    end

    it "has data_processing service" do
      service = Misty::services.find { |s| s.name == :data_processing}
      validate(service)
    end

    it "has data_protection service" do
      service = Misty::services.find { |s| s.name == :data_protection}
      validate(service)
    end

    it "has database service" do
      service = Misty::services.find { |s| s.name == :database}
      validate(service)
    end

    it "has dns service" do
      service = Misty::services.find { |s| s.name == :dns}
      validate(service)
    end

    it "has identity service" do
      service = Misty::services.find { |s| s.name == :identity}
      validate(service)
    end

    it "has image service" do
      service = Misty::services.find { |s| s.name == :image}
      validate(service)
    end

    it "has messaging service" do
      service = Misty::services.find { |s| s.name == :messaging}
      validate(service)
    end

    it "has metering service" do
      service = Misty::services.find { |s| s.name == :metering}
      validate(service)
    end

    it "has network service" do
      service = Misty::services.find { |s| s.name == :network}
      validate(service)
    end

    it "has object_storage service" do
      service = Misty::services.find { |s| s.name == :object_storage}
      validate(service)
    end

    it "has orchestration service" do
      service = Misty::services.find { |s| s.name == :orchestration}
      validate(service)
    end

    it "has search service" do
      service = Misty::services.find { |s| s.name == :search}
      validate(service)
    end

    it "has shared_file_systems service" do
      service = Misty::services.find { |s| s.name == :shared_file_systems}
      validate(service)
    end

    describe "#services" do
      it "returns Services" do
        services = Misty::services
        services.must_be_kind_of Misty::Services
      end
    end
  end

  describe "#to_json" do
    it "returns a JSON string when using a Ruby hash" do
      Misty.to_json({"key" => "val"}).must_be_kind_of String
    end

    it "returns same string when using a string" do
      data = "{\"key\": \"val\"}"
      response = Misty.to_json(data)
      response.must_be_kind_of String
      response.must_equal data
    end

    it "fails when using a string with non JSON data" do
      data = "key;val"
      proc do
        response = Misty.to_json(data)
      end.must_raise JSON::ParserError
    end
  end
end
