#!/usr/bin/env ruby
require 'misty'
require 'pp'

# In order ot obtain a scoped (project and domain) token:
auth_v3 = {
  :url      => 'http://localhost:5000',
  :user     => 'admin',
  :password => 'secret',
  :project  => 'admin',
  :domain   => 'default'
}

cloud = Misty::Cloud.new(:auth => auth_v3)

pp users = cloud.identity.list_users

nets = cloud.network.list_networks
first_network_id = nets.body['networks'][0]['id']
first_network = cloud.network.show_network_details(first_network_id)
pp first_network

network = Misty.to_json(:network => {:name => 'misty-example'})
pp cloud.network.create_network(network)
