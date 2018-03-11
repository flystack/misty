require 'misty/openstack/senlin/senlin_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module Senlin
      class V1
        include Misty::Openstack::SenlinV1
        include Misty::Openstack::ServicePack

        def service_types
          %w(clustering resource-cluster cluster)
        end
      end
    end
  end
end
