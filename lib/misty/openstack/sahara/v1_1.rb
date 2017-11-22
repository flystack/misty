require 'misty/openstack/sahara/sahara_v1_1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Sahara
      class V1_1
        extend Misty::Openstack::SaharaV1_1
        include Misty::ClientPack

        def api
          self.class.v1_1
        end

        def service_names
          %w{data-processing}
        end
      end
    end
  end
end
