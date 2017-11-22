require 'misty/openstack/karbor/karbor_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Karbor
      class V1
        extend Misty::Openstack::KarborV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def service_names
          %w{data-protection data-protection-orchestration}
        end
      end
    end
  end
end
