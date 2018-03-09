require 'misty/openstack/service'
require 'misty/http/net_http'
require 'misty/http/method_builder'
require 'misty/http/request'
require 'misty/http/direct'
require 'misty/http/header'

module Misty
  module Openstack
    module ServicePack
      include Misty::Openstack::Service
      include Misty::HTTP::NetHTTP
      include Misty::HTTP::MethodBuilder
      include Misty::HTTP::Request
      include Misty::HTTP::Direct
    end
  end
end
