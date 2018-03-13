module Misty::Openstack::API::CinderV2
  def tag
    'Block Storage API Reference 12.0.0'
  end

  def api
{"/"=>{:GET=>[:list_api_versions]},
 "/v2/{project_id}/backups/detail"=>{:GET=>[:list_backups_with_details]},
 "/v2/{project_id}/backups/{backup_id}"=>
  {:GET=>[:show_backup_details], :DELETE=>[:delete_backup]},
 "/v2/{project_id}/backups/{backup_id}/restore"=>{:POST=>[:restore_backup]},
 "/v2/{project_id}/backups"=>{:POST=>[:create_backup], :GET=>[:list_backups]},
 "/v2/{project_id}/backups/{backup_id}/export_record"=>
  {:GET=>[:export_backup]},
 "/v2/{project_id}/backups/{backup_id}/import_record"=>
  {:POST=>[:import_backup]},
 "/v2/{project_id}/backups/{backup_id}/action"=>
  {:POST=>[:force_delete_backup, :reset_backup_s_status]},
 "/v2/{project_id}/capabilities/{hostname}"=>
  {:GET=>[:show_back_end_capabilities]},
 "/v2/{project_id}/cgsnapshots/{cgsnapshot_id}"=>
  {:DELETE=>[:delete_consistency_group_snapshot],
   :GET=>[:show_consistency_group_snapshot_details]},
 "/v2/{project_id}/cgsnapshots/detail"=>
  {:GET=>[:list_consistency_group_snapshots_with_details]},
 "/v2/{project_id}/cgsnapshots"=>
  {:GET=>[:list_consistency_group_snapshots],
   :POST=>[:create_consistency_group_snapshot]},
 "/v2/{project_id}/consistencygroups"=>
  {:GET=>[:list_consistency_groups], :POST=>[:create_consistency_group]},
 "/v2/{project_id}/consistencygroups/{consistencygroup_id}"=>
  {:GET=>[:show_consistency_group_details]},
 "/v2/{project_id}/consistencygroups/create_from_src"=>
  {:POST=>[:create_consistency_group_from_source]},
 "/v2/{project_id}/consistencygroups/{consistencygroup_id}/delete"=>
  {:POST=>[:delete_consistency_group]},
 "/v2/{project_id}/consistencygroups/detail"=>
  {:GET=>[:list_consistency_groups_with_details]},
 "/v2/{project_id}/consistencygroups/{consistencygroup_id}/update"=>
  {:PUT=>[:update_consistency_group]},
 "/v2/{admin_project_id}/os-hosts"=>{:GET=>[:list_all_hosts]},
 "/v2/{admin_project_id}/os-hosts/{host_name}"=>{:GET=>[:show_host_details]},
 "/v2/{project_id}/limits"=>{:GET=>[:show_absolute_limits]},
 "/v2/{project_id}/scheduler-stats/get_pools"=>
  {:GET=>[:list_back_end_storage_pools]},
 "/v2/{project_id}/os-volume-transfer/{transfer_id}/accept"=>
  {:POST=>[:accept_volume_transfer]},
 "/v2/{project_id}/os-volume-transfer"=>
  {:POST=>[:create_volume_transfer], :GET=>[:list_volume_transfers]},
 "/v2/{project_id}/os-volume-transfer/{transfer_id}"=>
  {:GET=>[:show_volume_transfer_details], :DELETE=>[:delete_volume_transfer]},
 "/v2/{project_id}/os-volume-transfer/detail"=>
  {:GET=>[:list_volume_transfers_with_details]},
 "/v2/{project_id}/qos-specs/{qos_id}/disassociate_all"=>
  {:GET=>[:disassociate_qos_specification_from_all_associations]},
 "/v2/{project_id}/qos-specs/{qos_id}/delete_keys"=>
  {:PUT=>[:unset_keys_in_qos_specification]},
 "/v2/{project_id}/qos-specs/{qos_id}/associations"=>
  {:GET=>[:get_all_associations_for_qos_specification]},
 "/v2/{project_id}/qos-specs/{qos_id}/associate"=>
  {:GET=>[:associate_qos_specification_with_volume_type]},
 "/v2/{project_id}/qos-specs/{qos_id}/disassociate"=>
  {:GET=>[:disassociate_qos_specification_from_volume_type]},
 "/v2/{project_id}/qos-specs/{qos_id}"=>
  {:GET=>[:show_qos_specification_details],
   :PUT=>[:set_keys_in_qos_specification],
   :DELETE=>[:delete_qos_specification]},
 "/v2/{project_id}/qos-specs"=>
  {:POST=>[:create_qos_specification], :GET=>[:list_qos_specs]},
 "/v2/{admin_project_id}/os-quota-class-sets/{quota_class_name}"=>
  {:GET=>[:show_quota_classes], :PUT=>[:update_quota_classes]},
 "/v2/{admin_project_id}/os-quota-sets/{project_id}"=>
  {:GET=>[:show_quotas], :PUT=>[:update_quotas], :DELETE=>[:delete_quotas]},
 "/v2/{admin_project_id}/os-quota-sets/{project_id}/defaults"=>
  {:GET=>[:get_default_quotas]},
 "/v2/{project_id}/os-volume-manage"=>{:POST=>[:manage_existing_volume]},
 "/v2/{project_id}/types/{volume_type}/action"=>
  {:POST=>
    [:add_private_volume_type_access, :remove_private_volume_type_access]},
 "/v2/{project_id}/types/{volume_type}/os-volume-type-access"=>
  {:GET=>[:list_private_volume_type_access_details]},
 "/v2/{project_id}/extensions"=>{:GET=>[:list_api_extensions]},
 "/v2/{project_id}/snapshots/detail"=>{:GET=>[:list_snapshots_with_details]},
 "/v2/{project_id}/snapshots"=>
  {:POST=>[:create_snapshot], :GET=>[:list_snapshots]},
 "/v2/{project_id}/snapshots/{snapshot_id}/metadata"=>
  {:GET=>[:show_snapshot_metadata],
   :POST=>[:create_snapshot_metadata],
   :PUT=>[:update_snapshot_metadata]},
 "/v2/{project_id}/snapshots/{snapshot_id}"=>
  {:GET=>[:show_snapshot_details],
   :PUT=>[:update_snapshot],
   :DELETE=>[:delete_snapshot]},
 "/v2/{project_id}/types/{volume_type_id}"=>
  {:PUT=>[:update_volume_type, :update_extra_specs_for_a_volume_type],
   :GET=>[:show_volume_type_details_for_v2],
   :DELETE=>[:delete_volume_type]},
 "/v2/{project_id}/types"=>
  {:GET=>[:list_all_volume_types_for_v2], :POST=>[:create_volume_type_for_v2]},
 "/v2/{project_id}/types/{volume_type_id}/encryption"=>
  {:GET=>[:show_an_encryption_type_for_v2],
   :POST=>[:create_an_encryption_type_for_v2]},
 "/v2/{project_id}/types/{volume_type_id}/encryption/{encryption_id}"=>
  {:GET=>[:delete_an_encryption_type_for_v2],
   :PUT=>[:update_an_encryption_type_for_v2]},
 "/v2/"=>{:GET=>[:show_api_v2_details]},
 "/v2/{project_id}/volumes/{volume_id}/action"=>
  {:POST=>
    [:extend_volume_size,
     :reset_volume_statuses,
     :set_image_metadata_for_volume,
     :remove_image_metadata_from_volume,
     :show_image_metadata_for_volume,
     :attach_volume_to_server,
     :detach_volume_from_a_server,
     :unmanage_volume,
     :force_detach_volume,
     :retype_volume,
     :force_delete_volume,
     :update_volume_bootable_status]},
 "/v2/{project_id}/volumes/detail"=>{:GET=>[:list_volumes_with_details]},
 "/v2/{project_id}/volumes"=>{:POST=>[:create_volume], :GET=>[:list_volumes]},
 "/v2/{project_id}/volumes/{volume_id}"=>
  {:GET=>[:show_volume_details],
   :PUT=>[:update_volume],
   :DELETE=>[:delete_volume]},
 "/v2/{project_id}/volumes/{volume_id}/metadata"=>
  {:POST=>[:create_volume_metadata],
   :GET=>[:show_volume_metadata],
   :PUT=>[:update_volume_metadata]},
 "/v2/{project_id}/volumes/{volume_id}/metadata/{key}"=>
  {:GET=>[:show_volume_metadata_for_a_specific_key],
   :DELETE=>[:delete_volume_metadata],
   :PUT=>[:update_volume_metadata_for_a_specific_key]}}
  end
end
