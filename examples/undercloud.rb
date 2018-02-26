#!/usr/bin/env ruby
require 'misty'
require 'pp'

require './auth_v3'
cloud = Misty::Cloud.new(:auth => auth)

v1 = cloud.baremetal.show_v1_api
pp v1.body
