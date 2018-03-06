require 'test_helper'

heat_template1 = {
  'files': {},
  'disable_rollback': true,
  'stack_name': 'test_stack1',
  'template': {
    'heat_template_version': '2013-05-23',
    'description': 'Test Template 1',
    'resources': {
      'private_test_network': {
        'type': 'OS::Neutron::Net',
        'properties': { 'name': 'heat_test_network' }
      }
    }
  },
  'timeout_mins': 60
}

heat_template2 = {
  'files': {},
  'disable_rollback': true,
  'parameters': {
    'flavor': 'm1.tiny'
  },
  'stack_name': 'test_stack2',
  'template': {
    'heat_template_version': '2013-05-23',
    'description': 'Test Template 2',
    'parameters': {
      'flavor': {
        'default': 'm1.small',
        'type': 'string'
      }
    },
    'resources': {
      'hello_world': {
        'type': 'OS::Nova::Server',
        'properties': {
          'flavor': { 'get_param': 'flavor' },
          'image': '50fd6f2b-d9f0-41b6-b0a9-4482bfe61914',
          'user_data': '#!/bin/bash -xv\necho \'hello world\' &gt; /root/hello-world.txt\n'
        }
      }
    }
  },
  'timeout_mins': 60
}

describe 'Orchestration Service using Heat v1' do
  let(:auth) do
    {
      :url                => 'http://192.0.2.21:5000',
      :user               => 'admin',
      :password           => 'CJk9hb2ZFR96Ypu74KFFGWuhv',
      :project            => 'admin',
      :project_domain_id  => 'default',
      :domain             => 'default'
    }
  end

  it 'GET/POST/PUT/DELETE requests' do
    VCR.use_cassette 'orchestration using heat v1' do
      cloud = Misty::Cloud.new(:auth => auth, :orchestration => {:api_version => 'v1'})

      # POST with body data
      data_heat_template1 = Misty.to_json(heat_template1)
      response = cloud.orchestration.create_stack(data_heat_template1)
      response.code.must_equal '201'
      id1 = response.body['stack']['id']
      id1.wont_be_empty

      data_heat_template2 = Misty.to_json(heat_template2)
      response = cloud.orchestration.create_stack(data_heat_template2)
      response.code.must_equal '201'
      id2 = response.body['stack']['id']
      id2.wont_be_empty

      # GET
      response = cloud.orchestration.list_stacks
      response.code.must_equal '200'
      response.body['stacks'].size.must_equal 2

      # GET with URI value
      response = cloud.orchestration.show_stack_details('test_stack2', id2)
      response.code.must_equal '200'
      response.body['stack']['stack_name'].must_equal 'test_stack2'

      # PUT with URI value and body data
      # Updating the network template because it's faster to execute
      # therefore more likely to be in ready state before updating
      heat_template1[:template][:description] = 'Updated test template'
      data_heat_template1 = Misty.to_json(heat_template1)
      response = cloud.orchestration.update_stack('test_stack1', id1, data_heat_template1)
      response.code.must_equal '202'

      # PATCH with URI values
      data = Misty.to_json('disable_rollback': false)
      response = cloud.orchestration.update_stack_patch('test_stack1', id1, data)
      response.code.must_equal '202'

      # DELETE with URI value
      cloud.orchestration.delete_stack('test_stack1', id1).code.must_equal '204'
      cloud.orchestration.delete_stack('test_stack2', id2).code.must_equal '204'
    end
  end
end
