require 'test_helper'

VERBS = [ :COPY, :DELETE, :GET, :HEAD, :PATCH, :POST, :PUT ]

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
      else
        verb.must_equal :version
      end
    end
  end
end

# For each OpenStack project version, generates an equivalent of the following example:
# it 'Nova v2.1 loads a valid api structure' do
#   require 'misty/openstack/nova/v2_1'
#   api = Misty::Openstack::Nova::V2_1.api
#   api_valid?(api)
# end
describe 'Openstack API' do
  Misty.services.each do |service|
    service.versions.each do |version|
      it "#{service.project} #{version} loads a valid api structure" do
        require "misty/openstack/#{service.project}/#{Misty::Cloud.dot_to_underscore(version)}"
        api = Object.const_get("Misty::Openstack::#{service.project.capitalize}::#{Misty::Cloud.dot_to_underscore(version).capitalize}").api
        api_valid?(api)
      end
    end
  end
end
