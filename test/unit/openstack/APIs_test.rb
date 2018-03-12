require 'test_helper'

VERBS = [ :COPY, :DELETE, :GET, :HEAD, :PATCH, :POST, :PUT]

def api_valid?(api_entry)
  api_entry.each do |path, requests|
    path.must_be_kind_of String
    requests.must_be_kind_of Hash
    requests.each do |verb, names|
      verb.must_be_kind_of Symbol
      if VERBS.include? verb
        names.must_be_kind_of Array
        names.each do |name|
          name.must_be_kind_of Symbol
          name.to_s.wont_match /^id\d*/
        end
      end
    end
  end
end

def api_validate(project, version)
  it "#{project} #{version} loads a valid api structure" do
    require "misty/openstack/api/#{project}/#{project}_#{Misty::Cloud.dot_to_underscore(version)}"
    klass = Object.const_get("Misty::Openstack::API::#{project.capitalize}#{Misty::Cloud.dot_to_underscore(version).capitalize}")
    client = Object.new
    client.extend(klass)
    client.tag.must_match /API/
    api_valid?(client.api)
  end
end

# Assert each version of OpenStack project loads a valid api structure
describe 'Openstack API' do
  Misty.services.each do |service|
    if service.versions
      service.versions.each do |version|
        api_validate(service.project, version)
      end
    elsif service.microversion && !service.microversion.empty?
      api_validate(service.project, service.microversion)
    end
  end
end
