require 'misty/openstack/searchlight/searchlight_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Searchlight
      class V1
        extend Misty::Openstack::SearchlightV1
        include Misty::ClientPack

        def api
          self.class.v1
        end

        def service_names
          %w{search}
        end
      end
    end
  end
end
