module Misty::Openstack::TroveV1_0
  def v1_0
{"/"=>{:GET=>[:list_versions]},
 "/v1.0"=>{:GET=>[:show_version_details]},
 "/v1.0/{accountId}/instances/{instanceId}"=>
  {:DELETE=>[:delete_database_instance],
   :GET=>[:show_database_instance_details],
   :PUT=>[:attach_configuration_group, :detach_configuration_group],
   :PATCH=>[:detach_replica]},
 "/v1.0/{accountId}/instances"=>
  {:POST=>[:create_database_instance], :GET=>[:list_database_instances]},
 "/v1.0/{accountId}/instances/{instanceId}/configuration"=>
  {:GET=>[:list_configuration_defaults]},
 "/v1.0/{accountId}/instances/{instanceId}/action"=>
  {:POST=>
    [:restart_instance,
     :resize_instance,
     :resize_instance_volume,
     :promote_instance_to_replica_source,
     :delete_replication_base_instance]},
 "/v1.0/{accountId}/instances/{instanceId}/databases/{databaseName}"=>
  {:DELETE=>[:delete_database]},
 "/v1.0/{accountId}/instances/{instanceId}/databases"=>
  {:POST=>[:create_database], :GET=>[:list_instance_databases]},
 "/v1.0/{accountId}/instances/{instanceId}/root"=>
  {:POST=>[:enable_root_user],
   :GET=>[:show_root_enabled_status_for_database_instance],
   :DELETE=>[:disable_root_user]},
 "/v1.0/{accountId}/instances/{instanceId}/users/{name}"=>
  {:DELETE=>[:delete_user]},
 "/v1.0/{accountId}/instances/{instanceId}/users"=>
  {:POST=>[:create_user], :GET=>[:list_database_instance_users]},
 "/v1.0/{accountId}/flavors/{flavorId}"=>{:GET=>[:show_flavor_details]},
 "/v1.0/{accountId}/flavors"=>{:GET=>[:list_flavors]},
 "/v1.0/{accountId}/datastores/versions/{datastore_version_id}/parameters/{parameter_name}"=>
  {:GET=>[:show_configuration_parameter_details]},
 "/v1.0/{accountId}/datastores/{datastore_name}/versions"=>
  {:GET=>[:list_datastore_versions]},
 "/v1.0/{accountId}/datastores/versions/{datastore_version_id}/parameters"=>
  {:GET=>[:list_configuration_parameters]},
 "/v1.0/{accountId}/configurations"=>
  {:POST=>[:create_configuration_group], :GET=>[:list_configuration_groups]},
 "/v1.0/{accountId}/configurations/{configId}/instances"=>
  {:GET=>[:list_configuration_group_instances]},
 "/v1.0/{accountId}/configurations/{configId}"=>
  {:DELETE=>[:delete_configuration_group],
   :PATCH=>[:patch_configuration_group],
   :GET=>[:show_configuration_group_details],
   :PUT=>[:update_configuration_group]}}
  end
end
