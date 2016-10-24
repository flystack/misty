require 'test_helper'
require 'service_helper'
require 'misty/http/request'
require 'misty/http/direct'

describe Misty::HTTP::Direct do
  describe "#base_set" do
    it "returns @base_set" do
      service.base_set(nil).must_equal ""
    end

    it "returns parameter" do
      service.base_set("/another-base").must_equal "/another-base"
    end
  end

  describe "#delete" do
    it "successful without providing a base url" do
      stub_request(:delete, "http://localhost/resource/test").
        with(:headers => request_header).
        to_return(:status => 204, :body => '', :headers => {})

      response = service.delete('/resource/test')
      response.must_be_kind_of Net::HTTPNoContent
      response.body.must_be_nil
    end

    it "successful with a base url" do
      stub_request(:delete, "http://localhost/another-base/resource/test").
        with(:headers => request_header).
        to_return(:status => 204, :body => '', :headers => {})

      response = service.delete('/resource/test', "/another-base")
      response.must_be_kind_of Net::HTTPNoContent
      response.body.must_be_nil
    end
  end

  describe "#get" do
    it "successful without providing a base url" do
      stub_request(:get, "http://localhost/resource/test").
        with(:headers => request_header).
        to_return(:status => 200, :body => '', :headers => {})

      response = service.get('/resource/test')
      response.must_be_kind_of Net::HTTPOK
      response.body.must_be_nil
    end

    it "successful with a base url" do
      stub_request(:get, "http://localhost/another-base/resource/test").
        with(:headers => request_header).
        to_return(:status => 200, :body => '', :headers => {})

      response = service.get('/resource/test', "/another-base")
      response.must_be_kind_of Net::HTTPOK
      response.body.must_be_nil
    end
  end

  describe "#post" do
    it "successful without providing a base url" do
      stub_request(:post, "http://localhost/resource/test").
        with(:body => "{\"data\":\"value\"}", :headers => request_header).
        to_return(:status => 201, :body => '', :headers => {})

      response = service.post('/resource/test', "data" => "value")
      response.must_be_kind_of Net::HTTPCreated
      response.body.must_be_nil
    end

    it "successful with a base url" do
      stub_request(:post, "http://localhost/another-base/resource/test").
        with(:body => "{\"data\":\"value\"}", :headers => request_header).
        to_return(:status => 201, :body => '', :headers => {})
      response = service.post('/resource/test', {"data" => "value"}, "/another-base")
      response.must_be_kind_of Net::HTTPCreated
      response.body.must_be_nil
    end
  end

  describe "#put" do
    it "successful without providing a base url" do
      stub_request(:put, "http://localhost/resource/test").
        with(:body => "{\"data\":\"value\"}", :headers => request_header).
        to_return(:status => 200, :body => '', :headers => {})

      response = service.put('/resource/test', "data" => "value")
      response.must_be_kind_of Net::HTTPOK
      response.body.must_be_nil
    end

    it "successful with a base url" do
      stub_request(:put, "http://localhost/another-base/resource/test").
        with(:body => "{\"data\":\"value\"}", :headers => request_header).
        to_return(:status => 200, :body => '', :headers => {})

      response = service.put('/resource/test', {"data" => "value"}, "/another-base")
      response.must_be_kind_of Net::HTTPOK
      response.body.must_be_nil
    end
  end
end
