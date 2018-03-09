module Misty
  module Auth
    module Catalog
      attr_reader :payload

      def initialize(payload)
        @payload = payload
      end

      def get_endpoint_url(names, region, interface)
        entry = get_service(names)
        raise ServiceTypeError, 'Endpoint discovery: No service type match' unless entry
        find_url(entry, region, interface)
      end

      private

      def get_service(names)
        @payload.each do |entry|
          return entry if names.include?(entry['type'])
        end
        nil
      end

      def find_url(service, region, interface)
        if service['endpoints']
          service['endpoints'].each do |endpoint|
            if (url = endpoint_url(endpoint, region, interface))
              return url
            end
          end
        end
        raise EndpointError, "No endpoint found: service '#{service['type']}', region '#{region}',
          interface '#{interface}'"
      end
    end
  end
end
