require 'misty/openstack/api/gnocchi/gnocchi_v1'
require 'misty/openstack/service_pack'

module Misty
  module Openstack
    module API
      module Gnocchi
        class V1
          include Misty::Openstack::API::GnocchiV1
          include Misty::Openstack::ServicePack

          def service_types
            %w(metric)
          end
        end
      end
    end
  end
end
