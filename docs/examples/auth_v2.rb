#!/usr/bin/env ruby
require 'misty'
require 'pp'

# A V2 style authentication uses tenant (not project nor domain):
auth_v2 = {
  :url      => "http://localhost:5000",
  :user     => "admin",
  :password => "secret",
  :tenant   => "admin",
}

cloud = Misty::Cloud.new(:auth => auth_v2, :identity => {:base_path => ""})

nets = cloud.network.list_networks
pp nets.body
