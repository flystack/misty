require 'misty/services'
require 'logger'

# Misty is a HTTP client for OpenStack APIs, aiming to be fast, flexible and exhaustive.
# Misty acts as a conduit to OpenStack APIs by handling requests as transparently as possible.

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
    { name: :dns               ,                  project: :designate,   versions: ['v2']},
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

  # Default Domain ID
  DOMAIN_ID = 'default'

  def self.json_encode?(data)
    return true if data.is_a?(Array) || data.is_a?(Hash)
    if data.is_a?(String)
      begin
        JSON.parse(data)
      rescue JSON::ParserError
        return false
      else
        return true
      end
    end
    return false
  end

  # Provides list of supported services
  # ==== Example
  #     pp Misty.services

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
