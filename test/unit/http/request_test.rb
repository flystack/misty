require 'test_helper'
require 'service_helper'
require 'misty/http/request'

describe Misty::HTTP::Request do
  let(:request_header) { {'Accept' => '*/*'} }

  describe '#decode?' do
    let(:response) do
      uri = URI.parse('http://localhost/')
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new('/resource', {})
      http.request(request)
    end

    it 'true when response has a body' do
      stub_request(:get, 'http://localhost/resource').
        with(:headers => {'Accept' => '*/*'}).
        to_return(:status => 200, :body => "{\"key\": \"value\"}", :headers => {'Content-Type' => 'application/json'})

      service.decode?(response).must_equal true
    end

    it 'false when response has no content' do
      stub_request(:get, 'http://localhost/resource').
        with(:headers => {'Accept' => '*/*'}).
        to_return(:status => 204, :body => nil, :headers => {'Content-Type' => 'application/json'})

      service.decode?(response).must_equal false
    end

    it 'false when content_type is JSON' do
      stub_request(:get, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => 200, :body => "{\"blah\": \"bla\"}")

      service(:json).decode?(response).must_equal false
    end
  end

  describe 'http requests' do
    it '#http_copy' do
      stub_request(:copy, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => 202, :body => "{\"key\": \"value\"}")

      response = service.http_copy('/resource', {})
      response.must_be_kind_of Net::HTTPAccepted
      response.body.wont_be_nil
    end

    it '#http_delete' do
      stub_request(:delete, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => 204, :body => '')

      response = service.http_delete('/resource', {})
      response.must_be_kind_of Net::HTTPNoContent
      response.body.must_be_nil
    end

    it '#http_get' do
      stub_request(:get, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => 200, :body => "{\"key\": \"value\"}")

      response = service.http_get('/resource', {})
      response.must_be_kind_of Net::HTTPOK
      response.body.wont_be_empty
    end

    it '#http_head' do
      stub_request(:head, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => '200')

      response = service.http_head('/resource', {})
      response.must_be_kind_of Net::HTTPSuccess
      response.body.must_be_nil
    end

    it '#http_options' do
      stub_request(:options, 'http://localhost/resource').
        with(:headers => request_header).
        to_return(:status => '200')

      response = service.http_options('/resource', {})
      response.must_be_kind_of Net::HTTPSuccess
    end

    describe '#http_patch' do
      it 'successful with data of type String' do
        stub_request(:patch, 'http://localhost/resource').
          with(:body => "{\"data\":\"value\"}").
          with(:headers => request_header).
          to_return(:status => 202, :body => "{\"key\": \"value\"}")

        response = service.http_patch('/resource', {}, "{\"data\":\"value\"}")
        response.must_be_kind_of Net::HTTPAccepted
        response.body.wont_be_nil
      end
    end

    describe '#http_post' do
      it 'successful with data of type String' do
        stub_request(:post, 'http://localhost/resource').
          with(:body => "{\"data\":\"value\"}").
          with(:headers => request_header).
          to_return(:status => 201)

        response = service.http_post('/resource', {}, "{\"data\":\"value\"}")
        response.must_be_kind_of Net::HTTPCreated
      end
    end

    describe '#http_put' do
      it 'successful with data of type String' do
        stub_request(:put, 'http://localhost/resource').
          with(:body => "{\"data\":\"value\"}").
          with(:headers => request_header).
          to_return(:status => 200)

        response = service.http_put('/resource', {}, "{\"data\":\"value\"}")
        response.must_be_kind_of Net::HTTPOK
      end
    end

    it '#http_to_s' do
      service.http_to_s('VERB', 'resource', 'headers',  'data'  => 'value').must_equal "HTTP VERB 'localhost:80/resource', header=headers, data='{\"data\"=>\"value\"}'"
    end
  end
end
