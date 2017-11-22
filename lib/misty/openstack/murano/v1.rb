require 'misty/openstack/murano/murano_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Murano
      class V1
        extend Misty::Openstack::MuranoV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def service_names
          %w{application-catalog}
        end
      end
    end
  end
end
