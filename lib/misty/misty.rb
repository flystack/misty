require 'misty/services'
require 'misty/helper'
require 'misty/openstack'

module Misty
  def self.build(list)
    services_list = Misty::Services.new
    list.each  {|s| services_list.add(s)}
    services_list
  end

  def self.services
    @services ||= build(Misty::Openstack::SERVICES)
  end
end
