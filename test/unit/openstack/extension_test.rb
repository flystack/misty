require 'test_helper'
require 'misty/openstack/extension'

module DummyTestOpenstackExtension
  def api
    {
      "/v1/resource1"      => {
        :POST => [:method1, :method2],
        :GET  => [:method3, :method4]
      },
      "/v2/resource2/{id}" => {
        :GET    =>[:method5, :method6],
        :PATCH  =>[:method7, :method8],
        :DELETE =>[:method9, :method10]
      }
    }
  end

  def api_ext
    {
      "/v1/resource1"      => {
        :POST => [:method11, :method12],
        :PUT  => [:method13, :method14]
      },
      "/v1/resource3"      => {
        :POST => [:method, :method],
        :GET  => [:method]
      }
    }
  end
end

describe Misty::Openstack::Extension do
  let(:v1) do
    v1 = Object.new
    v1.extend(DummyTestOpenstackExtension)
    v1.extend(Misty::Openstack::Extension)
    v1
  end

  describe "Succesful" do
    it "Adds methods to existing Verb" do
      v1.api["/v1/resource1"][:POST].must_include :method11
    end

    it "Adds Verb" do
      v1.api["/v1/resource1"].must_include :PUT
    end

    it "Adds Resource" do
      v1.api.must_include "/v1/resource3"
    end
  end

  describe "Fails" do
    it "Raise RuntimeError when a resource already exist" do
      class << v1
        def api_ext
          { "/v1/resource1" => { :POST => [:method1] } }
        end
      end

      proc do
        v1.api
      end.must_raise RuntimeError
    end
  end
end
