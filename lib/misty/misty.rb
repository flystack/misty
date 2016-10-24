module Misty
  HEADER_JSON = {
    "Content-Type" => "application/json",
    "Accept"       => "application/json"
  }

  # Default log file. Use :log_file option to override
  LOG_FILE = "misty.log"
  # Default log level. Use :log_level option to override
  LOG_LEVEL = Logger::INFO

  Service = Struct.new(:name, :project, :versions) do
    def to_s
      "#{name}: #{project} => #{versions}"
    end
  end

  SERVICES = []
  SERVICES << Service.new(:alarming,            :aodh,         ["v2"])
  SERVICES << Service.new(:baremetal,           :ironic,       ["v1"])
  SERVICES << Service.new(:block_storage,       :cinder,       ["v3", "v1"])
  SERVICES << Service.new(:clustering,          :senlin,       ["v1"])
  SERVICES << Service.new(:compute,             :nova,         ["v2.1"])
  SERVICES << Service.new(:container,           :magnum,       ["v1"])
  SERVICES << Service.new(:data_processing,     :sahara,       ["v1.1"])
  SERVICES << Service.new(:data_protection,     :karbor,       ["v1"])
  SERVICES << Service.new(:database,            :trove,        ["v1.0"])
  SERVICES << Service.new(:dns,                 :designate,    ["v2"])
  SERVICES << Service.new(:identity,            :keystone,     ["v3", "v2.0"])
  SERVICES << Service.new(:image,               :glance,       ["v2", "v1"])
  SERVICES << Service.new(:messaging,           :zaqar,        ["v2"])
  SERVICES << Service.new(:metering,            :ceilometer,   ["v2"])
  SERVICES << Service.new(:network,             :neutron,      ["v2.0"])
  SERVICES << Service.new(:object_storage,      :swift,        ["v1"])
  SERVICES << Service.new(:orchestration,       :heat,         ["v1"])
  SERVICES << Service.new(:search,              :searchlight,  ["v1"])
  SERVICES << Service.new(:shared_file_systems, :manila,       ["v2"])
  SERVICES.freeze

  def self.services
    SERVICES
  end

  def self.to_json(data)
    if data.is_a? String
      JSON.parse(data)
      return data
    end
    return JSON.dump(data)
  end
end
