#!/usr/bin/env ruby
require 'misty'
require 'pp'

require './auth_v3'
# Authenticate using a V3 style but force the identity service to use v2.0
cloud = Misty::Cloud.new(:auth => auth_v3, :identity => {:api_version => "v2.0"} )

# v2 uses list_tenants as list_users doesn't exist yet:
users = cloud.identity.list_tenants
pp users.body
