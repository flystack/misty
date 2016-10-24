require 'test_helper'

describe Misty do
  describe "SERVICES" do
    it "has expected structure" do
      Misty::SERVICES.each do |service|
        service.name.must_be_kind_of Symbol
        service.project.must_be_kind_of Symbol
        service.versions.must_be_kind_of Array
        service.versions.each do |version|
          version.must_be_kind_of String
        end
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
