module Misty
  # Microvesion handles OpenStack Services supporting Microversion feature
  #
  # ==== Examples
  # Use +:version+ option
  #     cloud = Misty::Cloud.new(:auth => { ... })
  #     pp cloud.compute.versions
  #     => [{"status"=>"SUPPORTED",
  #     "updated"=>"2011-01-21T11:33:21Z",
  #     "links"=>[{"href"=>"http://192.0.2.1:8774/v2/", "rel"=>"self"}],
  #     "min_version"=>"",
  #     "version"=>"",
  #     "id"=>"v2.0"},
  #     {"status"=>"CURRENT",
  #     "updated"=>"2013-07-23T11:33:21Z",
  #     "links"=>[{"href"=>"http://192.0.2.1:8774/v2.1/", "rel"=>"self"}],
  #     "min_version"=>"2.1",
  #     "version"=>"2.53",
  #     "id"=>"v2.1"}]
  #
  #     cloud.compute(:version => '2.25')
  #     data_keypair = Misty.to_json('keypair': {'name': 'admin-keypair'})
  #     admin_keypair = cloud.compute.create_or_import_keypair(data_keypair)
  #     user_id = admin_keypair.body['keypair']['user_id']
  #     keypairs = cloud.compute.list_keypairs
  #     pp keypairs.body
  #
  # Nova version 2.10+, a keypair name can be filtered by user_id
  #     user_id=1e50c2f0995446fd9b135a1a549cabdb'
  #     cloud.compute(:version => '2.10')show_keypair_details("admin-keypair?user_id=#{user_id}")
  #
  # Nova version 2.2+ the type field is returned too when showing keypair details
  #     cloud.compute(:version => '2.2')
  #     pp admin_keypair.body
  #     => {'keypair'=>
  #          {'public_key'=>
  #            'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjenEe7B87OQHYjZAdJWmaY13mF0N3VooviHypEXaSDfEmFj4GinXorKD0kdXAL30orT0wgAVtpAvRhH2iFTPF2VKCdq4VMzLuai60e3oB3vsTWdZQIJtvaW0mpTNVUQKczbFhRFUi4CNsAijjmGJJgxhihd6rAfynFtalLO0yNn3dKtEMbsvs7KeMxT9SXbfLmEXD4reAK/WXQBVjrEjJIgpC3+SXOO6vsavaOTFu7/Nbha/p4g4yJ3rHUU+7lj79a7iy0sNeExBSZ2aKTq7FQ5XDmtZjjpUeas16kMMX5HdxISYkbq3QnG9iTrIy+GEAYKkZPzhuAa76Qpze35aV Generated-by-Nova\n',
  #           'user_id'=>'1e50c2f0995446fd9b135a1a549cabdb',
  #           'name'=>'admin-keypair',
  #           'deleted'=>false,
  #           'created_at'=>'2016-11-23T01:23:53.000000',
  #           'updated_at'=>nil,
  #           'fingerprint'=>'4e:db:2d:bd:93:70:01:b8:61:17:96:23:e0:78:e2:69',
  #           'deleted_at'=>nil,
  #           'type'=>'ssh',
  #           'id'=>8}}

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
