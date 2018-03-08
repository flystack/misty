require 'misty/openstack/tacker/tacker_v1_0'
require 'misty/client_pack'

module Misty
  module Openstack
    module Tacker
      class V1_0
        include Misty::Openstack::TackerV1_0
        include Misty::ClientPack

        def service_types
          %w(nfv-orchestration)
        end
      end
    end
  end
end
