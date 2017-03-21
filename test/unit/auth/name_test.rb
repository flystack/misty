require 'test_helper'
require 'misty/auth/name'

describe Misty::Auth::Name do
  describe "creates" do
    it "when id and name are provided" do
      name = Misty::Auth::Name.new("default", "Default")
      name.id.must_equal "default"
      name.name.must_equal "Default"
    end

    it "when id is null" do
      name = Misty::Auth::Name.new(nil, "Default")
      name.id.must_be_nil
      name.name.must_equal "Default"
    end

      name = Misty::Auth::Name.new(nil, nil)
    it "when name is null" do
      name = Misty::Auth::Name.new("default", nil)
      name.id.must_equal "default"
      name.name.must_be_nil
    end

    it "when both id and name is null" do
      name = Misty::Auth::Name.new(nil, nil)
      name.name.must_be_nil
    end
  end

  describe "#to_h" do
    it "returns the hash of provided attribute" do
      name = Misty::Auth::Name.new("default", "Default")
      name.to_h(:id).must_equal ({:id => "default"})
      name.to_h(:name).must_equal ({:name => "Default"})
    end
  end
end

describe Misty::Auth::User do
  describe "#password" do
    it "set/get password" do
      user = Misty::Auth::User.new("user_id", "User")
      user.password = "secret"
      user.identity.must_equal ({:user=>{:id=>"user_id", :password=>"secret"}})
    end
  end

  describe "#identity" do
    it "raises an error when password is missing" do
      proc do
        user = Misty::Auth::User.new("user_id", "User")
        user.identity
      end.must_raise Misty::Auth::CredentialsError
    end

    it "when id is provided it doesn't require domain" do
      user = Misty::Auth::User.new("user_id", "User")
      user.password = "secret"
      user.identity.must_equal ({:user=>{:id=>"user_id", :password=>"secret"}})
    end

    it "when id is nul and name is provided it uses domain id" do
      user = Misty::Auth::User.new(nil, "User")
      user.password = "secret"
      user.domain = Misty::Auth::Name.new("default", nil)
      user.identity.must_equal ({:user=>{:name=>"User", :domain=>{:id=>"default"}, :password=>"secret"}})
    end

    it "when id is nul and name is provided it uses domain name" do
      user = Misty::Auth::User.new(nil, "User")
      user.password = "secret"
      user.domain = Misty::Auth::Name.new(nil, "Default")
      user.identity.must_equal ({:user=>{:name=>"User", :domain=>{:name=>"Default"}, :password=>"secret"}})
    end

    it "raises an error with no user id and no domain are provided" do
      proc do
        user = Misty::Auth::User.new(nil, "User")
        user.identity
      end.must_raise Misty::Auth::CredentialsError
    end
  end
end

describe Misty::Auth::Project do
  describe "#identity" do
    it "when id is provided it doesn't require domain" do
      project = Misty::Auth::Project.new("project_id", "Project")
      project.identity.must_equal ({:project=>{:id=>"project_id"}})
    end

    it "when id is nul and name is provided it uses domain id" do
      project = Misty::Auth::Project.new(nil, "Project")
      project.domain = Misty::Auth::Name.new("default", nil)
      project.identity.must_equal ({:project=>{:name=>"Project", :domain=>{:id=>"default"}}})
    end

    it "when id is nul and name is provided it uses domain name" do
      project = Misty::Auth::Project.new(nil, "Project")
      project.domain = Misty::Auth::Name.new(nil, "Default")
      project.identity.must_equal ({:project=>{:name=>"Project", :domain=>{:name=>"Default"}}})
    end

    it "raises an error with no project id and no domain are provided" do
      proc do
        project = Misty::Auth::Project.new(nil, "Project")
        project.identity
      end.must_raise Misty::Auth::CredentialsError
    end
  end
end
