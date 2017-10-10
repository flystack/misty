#!/usr/bin/env ruby
require 'misty'
require 'pp'

require './auth_v3'

heat_template = {
  "files": {},
  "disable_rollback": true,
  "parameters": {
    "flavor": "m1.tiny"
  },
  "stack_name": "test_stack",
  "template": {
    "heat_template_version": "2013-05-23",
    "description": "Template to test heat",
    "parameters": {
      "flavor": {
        "default": "m1.small",
        "type": "string"
      }
    },
    "resources": {
      "hello_world": {
        "type": "OS::Nova::Server",
        "properties": {
          "flavor": { "get_param": "flavor" },
          "image": "50fd6f2b-d9f0-41b6-b0a9-4482bfe61914",
          "user_data": "#!/bin/bash -xv\necho \"hello world\" &gt; /root/hello-world.txt\n"
        }
      }
    }
  },
  "timeout_mins": 60
}

cloud = Misty::Cloud.new(:auth => auth_v3)
data_heat_template = Misty.to_json(heat_template)
response = cloud.orchestration.create_stack(data_heat_template)
id = response.body['stack']['id']

stack = cloud.orchestration.show_stack_details('test_stack', id)
pp stack.body
