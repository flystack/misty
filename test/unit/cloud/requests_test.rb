require 'test_helper'
require 'auth_helper'

describe Misty::Cloud do
  let(:cloud) do
    auth = {
      :url                => 'http://localhost:5000',
      :user               => 'admin',
      :password           => 'secret',
      :project            => 'admin',
      :project_domain_id  => 'default',
      :domain             => 'default'
    }

    Misty::Cloud.new(:auth => auth)
  end

  describe 'GET request' do
    it 'success without elements in path' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('network', 'neutron')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:get, 'http://localhost/v2.0/networks').
        to_return(:status => 200, :body => 'list of networks', :headers => {})

      cloud.network.list_networks.response.must_be_kind_of Net::HTTPOK
    end

    it 'success adds the query option in path' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('network', 'neutron')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:get, 'http://localhost/v2.0/networks?name=value').
        to_return(:status => 200, :body => 'list of networks', :headers => {})

      cloud.network.list_networks('name=value').response.must_be_kind_of Net::HTTPOK
    end

    it 'successful whith elements in path' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('image', 'glance')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:get, 'http://localhost/v2/images/id1/members/id2').
        to_return(:status => 200, :body => 'list of images', :headers => {})

      cloud.image.show_image_member_details('id1', 'id2').response.must_be_kind_of Net::HTTPOK
    end

    it 'fails when not enough arguments' do
      proc do
        # '/v2/images/{image_id}/members/{member_id}'
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
          to_return(:status => 200, :body => JSON.dump(auth_response_v3('image', 'glance')), :headers => {'x-subject-token'=>'token_data'})

        cloud.image.show_image_member_details('id1')
      end.must_raise ArgumentError
    end
  end

  describe 'POST request' do
    it 'successful without elements in path' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:post, 'http://localhost/v3/projects').
        to_return(:status => 201, :body => 'list of projects', :headers => {})

      cloud.identity.create_project("{\"project\":{\"name\":\"value\"}}").response.must_be_kind_of Net::HTTPCreated
    end

    it 'sucessful whith elements in pathwhith elements in path' do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
          to_return(:status => 200, :body => JSON.dump(auth_response_v3('orchestration', 'heat')), :headers => {'x-subject-token'=>'token_data'})

        stub_request(:post, 'http://localhost/stacks/id1/id2/snapshots').
        to_return(:status => 201, :body => 'snapshots', :headers => {})

        cloud.orchestration.snapshot_a_stack("id1", "id2", "{\"key\": \"value\"}").response.must_be_kind_of Net::HTTPCreated
    end

    it 'fails when not enough arguments' do
      proc do
        stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
          to_return(:status => 200, :body => JSON.dump(auth_response_v3('orchestration', 'heat')), :headers => {'x-subject-token'=>'token_data'})

        cloud.orchestration.snapshot_a_stack('id1')
      end.must_raise ArgumentError
    end
  end

  describe 'DELETE request' do
    it 'success' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:delete, 'http://localhost/v3/projects/project_id').
        to_return(:status => 204, :body => 'list of projects', :headers => {})

      cloud.identity.delete_project('project_id').response.must_be_kind_of Net::HTTPNoContent
    end
  end

  describe 'PUT request' do
    it 'success' do
      stub_request(:post, 'http://localhost:5000/v3/auth/tokens').
        to_return(:status => 200, :body => JSON.dump(auth_response_v3('identity', 'keystone')), :headers => {'x-subject-token'=>'token_data'})

      stub_request(:put, 'http://localhost/v3/domains/domain_id/groups/group_id/roles/roles_id').
        to_return(:status => 200, :body => 'list of group/role for a domain', :headers => {})

      cloud.identity.assign_role_to_group_on_domain('domain_id', 'group_id', 'roles_id').response.must_be_kind_of Net::HTTPOK
    end
  end
end
