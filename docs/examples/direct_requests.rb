#!/usr/bin/env ruby
require 'misty'
require 'pp'

require './auth_v3'
cloud = Misty::Cloud.new(:auth => auth_v3)

net = cloud.network.get("/v2.0/networks")
pp net.body

id = cloud.identity.get("/")
pp id.body

servers = cloud.compute.get("/servers")
pp servers.body

img = cloud.image.get("/v1")
pp img.body
