module Misty
  # Handles OpenStack Services supporting Microversion feature
  module Microversion
    def set_version
      @version = case @asked_version
                 when nil || ''
                   # TODO:
                   # version_discovery
                 when 'latest'
                   'latest'
                 when /^([1-9]+\d*)\.([1-9]+\d*)$/
                   @asked_version if version_match(@asked_version)
                 else
                   raise VersionError, ":version must be '<number.number>' or 'latest'"
                 end

      @headers.add(microversion_header) if @version
    end

    def microversion_header
      {'X-Openstack-API-Version' => "#{self.class.to_s.split('::')[-1].downcase} #{@version}" }
    end
    private

    def version_match(number)
      versions.each do |version|
        return number if version['min_version'] <= number && version['version'] >= number
      end
      raise VersionError, "Version #{number} is out of range of available versions #{versions}"
    end

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
  end
end
