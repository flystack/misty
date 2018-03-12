require 'misty/services'
require 'misty/helper'

module Misty
  OPENSTACK_SERVICES = './lib/misty/openstack_services.yaml'

  def self.services
    @services ||= Misty::Services.build(OPENSTACK_SERVICES)
  end
end
