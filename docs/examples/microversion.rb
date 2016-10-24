#!/usr/bin/env ruby
require 'misty'
require 'pp'

require './auth_v3'
cloud = Misty::Cloud.new(:auth => authv3, :compute => {:version => "2.25"})

pp cloud.compute.versions

admin_keypair = cloud.compute.create_or_import_keypair("keypair": {"name": "admin-keypair"})

user_id = admin_keypair.body["keypair"]["user_id"]

keypairs = cloud.compute.list_keypairs
pp keypairs.body

# From Nova version 2.10, a keypair name can be filtered by user_id.
# For example: "/v2.1/os-keypairs/admin-keypair?user_id=1e50c2f0995446fd9b135a1a549cabdb"
admin_keypair = cloud.compute.show_keypair_details("admin-keypair?user_id=#{user_id}")

# From Nova version 2.2 the type field is returned too when showing keypair details
pp admin_keypair.body

# For example:
#{"keypair"=>
#  {"public_key"=>
#    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjenEe7B87OQHYjZAdJWmaY13mF0N3VooviHypEXaSDfEmFj4GinXorKD0kdXAL30orT0wgAVtpAvRhH2iFTPF2VKCdq4VMzLuai60e3oB3vsTWdZQIJtvaW0mpTNVUQKczbFhRFUi4CNsAijjmGJJgxhihd6rAfynFtalLO0yNn3dKtEMbsvs7KeMxT9SXbfLmEXD4reAK/WXQBVjrEjJIgpC3+SXOO6vsavaOTFu7/Nbha/p4g4yJ3rHUU+7lj79a7iy0sNeExBSZ2aKTq7FQ5XDmtZjjpUeas16kMMX5HdxISYkbq3QnG9iTrIy+GEAYKkZPzhuAa76Qpze35aV Generated-by-Nova\n",
#   "user_id"=>"1e50c2f0995446fd9b135a1a549cabdb",
#   "name"=>"admin-keypair",
#   "deleted"=>false,
#   "created_at"=>"2016-11-23T01:23:53.000000",
#   "updated_at"=>nil,
#   "fingerprint"=>"4e:db:2d:bd:93:70:01:b8:61:17:96:23:e0:78:e2:69",
#   "deleted_at"=>nil,
#   "type"=>"ssh",
#   "id"=>8}}
