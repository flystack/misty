module Misty
  # TODO: move to Openstack module
  module HTTP
    module Microversion
      class VersionError < RuntimeError; end

      VERSION_STATES = %w{CURRENT LATEST SUPPORTED}

      def initialize(auth, cloud, options)
        super
        @microversion = true
        @version = version_get(@options.version)
      end

      def version_get(version_option)
        if VERSION_STATES.include?(version_option)
          return version_by_state(version_option)
        else
          return version_by_number(version_option)
        end
      end

      def versions
        @versions ||= versions_fetch
      end

      private

      def version_by_number(number)
        versions.each do |version|
          return number if version['min_version'] <= number && version['version'] >= number
        end
        raise VersionError, "Version #{number} is out of range of available versions #{versions}"
      end

      def version_by_state(state)
        version_details = nil
        versions.each do |version|
          if version['status'] == state
            version_details = version
            break
          end
        end
        raise VersionError, "Version #{state} is not available among #{versions}" if version_details.nil?
        if version_details['version'].empty?
          @microversion = false
          return ''
        end
        version_details['version']
      end

      def versions_fetch
        response = http_get('/', headers_default)
        raise VersionError, "Code: #{response.code}, Message: #{response.msg}" unless response.code =~ /2??/
        data = response.body.is_a?(Hash) ? response.body : JSON.parse(response.body)
        list = data['versions']
        raise VersionError, 'Missing version data' unless list
        list
      end
    end
  end
end
