require 'misty/services'

module Misty
  HEADER_JSON = {
    "Content-Type" => "application/json",
    "Accept"       => "application/json"
  }

  # Default log file. Use :log_file option to override
  LOG_FILE = "misty.log"
  # Default log level. Use :log_level option to override
  LOG_LEVEL = Logger::INFO

  # Default content type for REST responses
  # JSON format: :json
  # Ruby structures: :ruby
  CONTENT_TYPE = :ruby

  # Defaults Domain ID
  DOMAIN_ID = "default"

  # Default Interface
  INTERFACE = "public"

  # Default Region ID
  REGION_ID = "regionOne"

  # Default mode when SSL is used (uri.scheme == "https")
  SSL_VERIFY_MODE = true

  def self.services
    services = Misty::Services.new
    services.add(:application_catalog, :murano,       ["v1"])
    services.add(:alarming,            :aodh,         ["v2"])
    services.add(:backup,              :freezer,      ["v1"])
    services.add(:baremetal,           :ironic,       ["v1"])
    services.add(:block_storage,       :cinder,       ["v3", "v1"])
    services.add(:clustering,          :senlin,       ["v1"])
    services.add(:compute,             :nova,         ["v2.1"])
    services.add(:container,           :magnum,       ["v1"])
    services.add(:data_processing,     :sahara,       ["v1.1"])
    services.add(:data_protection,     :karbor,       ["v1"])
    services.add(:database,            :trove,        ["v1.0"])
    services.add(:dns,                 :designate,    ["v2"])
    services.add(:identity,            :keystone,     ["v3", "v2.0"])
    services.add(:image,               :glance,       ["v2", "v1"])
    services.add(:load_balancer,       :octavia,      ["v2.0"])
    services.add(:messaging,           :zaqar,        ["v2"])
    services.add(:metering,            :ceilometer,   ["v2"])
    services.add(:networking,          :neutron,      ["v2.0"])
    services.add(:nfv_orchestration,   :tacker,       ["v1.0"])
    services.add(:object_storage,      :swift,        ["v1"])
    services.add(:orchestration,       :heat,         ["v1"])
    services.add(:search,              :searchlight,  ["v1"])
    services.add(:shared_file_systems, :manila,       ["v2"])
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
