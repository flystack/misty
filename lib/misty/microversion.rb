module Misty
  # Handles OpenStack Services supporting Microversion feature
  module Microversion
    def set_version(version)
      case version
      when nil || ''
        # TODO:
        # version_discovery
      when 'latest'
        'latest'
      when /^([1-9]+\d*)\.([1-9]+\d*)$/
        version if version_match(version)
      else
        raise VersionError, ":version must be '<number.number>' or 'latest'"
      end
    end

    def microversion_header(version)
      {'X-Openstack-API-Version' => "#{service_types[0]} #{version}" }
    end

    private

    def versions
      @versions ||= versions_fetch
    end

    def versions_fetch
      response = http_get('/', {'Accept'=> 'application/json'})
      raise VersionError, "Code: #{response.code}, Message: #{response.msg}" unless response.code =~ /2??/
      data = response.body.is_a?(Hash) ? response.body : JSON.parse(response.body)
      list = data['versions']
      raise VersionError, 'Missing version data' unless list
      list
    end

    def version_match(number)
      versions.each do |version|
        return number if version['min_version'] <= number && version['version'] >= number
      end
      raise VersionError, "Version #{number} is out of range of available versions: #{versions}"
    end
  end
end
