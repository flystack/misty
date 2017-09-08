require 'misty/services'

module Misty
  SERVICES = [
    { name: :application_catalog,                 project: :murano,      versions: ['v1']},
    { name: :alarming,                            project: :aodh,        versions: ['v2']},
    { name: :backup,                              project: :freezer,     versions: ['v1']},
    { name: :baremetal,                           project: :ironic,      microversion: 'v1'},
    { name: :block_storage,                       project: :cinder,      microversion: 'v3', versions: ['v2', 'v1']},
    { name: :clustering,                          project: :senlin,      versions: ['v1']},
    { name: :compute,                             project: :nova,        microversion: 'v2.1'},
    { name: :container_infrastructure_management, project: :magnum,      microversion: 'v1'},
    { name: :data_processing,                     project: :sahara,      versions: ['v1.1']},
    { name: :data_protection_orchestration,       project: :karbor,      versions: ['v1']},
    { name: :database,                            project: :trove,       versions: ['v1.0']},
    { name: :domain_name_server,                  project: :designate,   versions: ['v2']},
    { name: :identity,                            project: :keystone,    versions: ['v3', 'v2.0']},
    { name: :image,                               project: :glance,      versions: ['v2', 'v1']},
    { name: :load_balancer,                       project: :octavia,     versions: ['v2.0']},
    { name: :messaging,                           project: :zaqar,       versions: ['v2']},
    { name: :metering,                            project: :ceilometer,  versions: ['v2']},
    { name: :networking,                          project: :neutron,     versions: ['v2.0']},
    { name: :nfv_orchestration,                   project: :tacker,      versions: ['v1.0']},
    { name: :object_storage,                      project: :swift,       versions: ['v1']},
    { name: :orchestration,                       project: :heat,        versions: ['v1']},
    { name: :search,                              project: :searchlight, versions: ['v1']},
    { name: :shared_file_systems,                 project: :manila,      microversion: 'v2'}
  ]

  HEADER_JSON = {
    'Content-Type' => 'application/json',
    'Accept'       => 'application/json'
  }

  # Default REST content type. Use :json or :ruby
  CONTENT_TYPE = :ruby

  # Default Domain ID
  DOMAIN_ID = 'default'

  # Default Interface
  INTERFACE = 'public'

  # Default log file. Use :log_file option to override
  LOG_FILE = 'misty.log'

  # Default log level. Use :log_level option to override
  LOG_LEVEL = Logger::INFO

  # Default Region ID
  REGION_ID = 'regionOne'

  # Default when uri.scheme is https
  SSL_VERIFY_MODE = true

  def self.services
    services = Misty::Services.new
    SERVICES.each do |service|
      services.add(service)
    end
    services
  end

  def self.to_json(data)
    if data.is_a? String
      JSON.parse(data)
      return data
    end
    return JSON.dump(data)
  end
end
