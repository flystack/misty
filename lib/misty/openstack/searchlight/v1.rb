require 'misty/openstack/searchlight/searchlight_v1'
require 'misty/client_pack'

module Misty
  module Openstack
    module Searchlight
      class V1
        include Misty::Openstack::SearchlightV1
        include Misty::ClientPack

        def service_types
          %w(search)
        end
      end
    end
  end
end
