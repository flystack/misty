module Misty::Openstack::ManilaV2
  def api
{"/"=>{:GET=>[:list_all_major_versions]},
 "/{api_version}"=>{:GET=>[:show_details_of_specific_api_version]},
 "/v2/{tenant_id}/extensions"=>{:GET=>[:list_extensions]},
 "/v2/{tenant_id}/limits"=>{:GET=>[:list_share_limits]},
 "/v2/{tenant_id}/shares"=>{:GET=>[:list_shares], :POST=>[:create_share]},
 "/v2/{tenant_id}/shares/detail"=>{:GET=>[:list_shares_with_details]},
 "/v2/{tenant_id}/shares/{share_id}"=>
  {:GET=>[:show_share_details],
   :PUT=>[:update_share],
   :DELETE=>[:delete_share]},
 "/v2/{tenant_id}/shares/manage"=>{:GET=>[:manage_share]},
 "/v2/{tenant_id}/shares/{share_id}/export_locations"=>
  {:GET=>[:list_export_locations]},
 "/v2/{tenant_id}/shares/{share_id}/export_locations/​{export_location_id}​"=>
  {:GET=>[:show_single_export_location]},
 "/v2/{tenant_id}/shares/{share_id}/metadata"=>
  {:GET=>[:show_share_metadata],
   :POST=>[:set_share_metadata],
   :PUT=>[:update_share_metadata]},
 "/v2/{tenant_id}/shares/{share_id}/metadata/{key}"=>
  {:DELETE=>[:unset_share_metadata]},
 "/v2/{tenant_id}/shares/{share_id}/action"=>
  {:POST=>
    [:grant_access,
     :revoke_access,
     :list_access_rules,
     :reset_share_state,
     :force_delete_share,
     :extend_share,
     :shrink_share,
     :unmanage_share,
     :revert_share_to_snapshot,
     :migrate_share_versions_2_5_to_2_14,
     :start_migration_since_version_2_15,
     :complete_migration_since_version_2_15]},
 "/v2/{tenant_id}/snapshots"=>
  {:GET=>[:list_share_snapshots], :POST=>[:create_share_snapshot]},
 "/v2/{tenant_id}/snapshots/detail"=>
  {:GET=>[:list_share_snapshots_with_details]},
 "/v2/{tenant_id}/snapshots/{snapshot_id}"=>
  {:GET=>[:show_share_snapshot_details],
   :PUT=>[:update_share_snapshot],
   :DELETE=>[:delete_share_snapshot]},
 "/v2/{tenant_id}/snapshots/manage"=>{:POST=>[:manage_share_snapshot]},
 "/v2/{tenant_id}/snapshots/{snapshot_id}/action"=>
  {:POST=>
    [:unmanage_share_snapshot,
     :reset_share_snapshot_state,
     :force_delete_share_snapshot]},
 "/v2/{tenant_id}/share-networks"=>
  {:GET=>[:list_share_networks], :POST=>[:create_share_network]},
 "/v2/{tenant_id}/share-networks/detail"=>
  {:GET=>[:list_share_networks_with_details]},
 "/v2/{tenant_id}/share-networks/{share_network_id}"=>
  {:GET=>[:show_share_network_details],
   :PUT=>[:update_share_network],
   :DELETE=>[:delete_share_network]},
 "/v2/{tenant_id}/share-networks/{share_network_id}/action"=>
  {:POST=>
    [:add_security_service_to_share_network,
     :remove_security_service_from_share_network]},
 "/v2/{tenant_id}/security-services"=>
  {:GET=>[:list_security_services], :POST=>[:create_security_service]},
 "/v2/{tenant_id}/security-services/detail"=>
  {:GET=>[:list_security_services_with_details]},
 "/v2/{tenant_id}/security-services/{security_service_id}"=>
  {:GET=>[:show_security_service_details],
   :PUT=>[:update_security_service],
   :DELETE=>[:delete_security_service]},
 "/v2/{tenant_id}/share-servers"=>{:GET=>[:list_share_servers]},
 "/v2/{tenant_id}/share-servers/{share_server_id}/detail"=>
  {:GET=>[:show_share_server_details]},
 "/v2/{tenant_id}/share-servers/{share_server_id}"=>
  {:DELETE=>[:delete_share_server]},
 "/v2/{tenant_id}/share_instances"=>{:GET=>[:list_share_instances]},
 "/v2/{tenant_id}/share_instances/{share_instance_id}"=>
  {:GET=>[:show_share_instance_details]},
 "/v2/{tenant_id}/share_instances/{share_instance_id}/action"=>
  {:POST=>[:reset_share_instance_state, :force_delete_share_instance]},
 "/v2/{tenant_id}/share_instances/{share_instance_id}/export_locations"=>
  {:GET=>[:list_export_locations_by_share_instance]},
 "/v2/{tenant_id}/share_instances/{share_instance_id}/export_locations/{export_location_id}"=>
  {:GET=>[:show_single_export_location_by_share_instance]},
 "/v2/{tenant_id}/types"=>
  {:GET=>[:list_share_types], :POST=>[:create_share_type]},
 "/v2/{tenant_id}/types/default"=>{:GET=>[:list_default_share_types]},
 "/v2/{tenant_id}/types/{share_type_id}/extra_specs"=>
  {:GET=>[:list_extra_specs], :POST=>[:set_extra_spec_for_share_type]},
 "/v2/{tenant_id}/types/{share_type_id}/share_type_access"=>
  {:GET=>[:show_share_type_access_details]},
 "/v2/{tenant_id}/types/{share_type_id}/extra_specs/{extra-spec-key}"=>
  {:DELETE=>[:unset_an_extra_spec]},
 "/v2/{tenant_id}/types/{share_type_id}/action"=>
  {:POST=>[:add_share_type_access, :remove_share_type_access]},
 "/v2/{tenant_id}/types/{share_type_id}"=>{:DELETE=>[:delete_share_type]},
 "/v2/{tenant_id}/scheduler-stats/pools?pool={pool_name}&host={host_name}&backend={backend_name}&capabilities={capabilities}&share_type={share_type}"=>
  {:GET=>[:list_back_end_storage_pools]},
 "/v2/{tenant_id}/scheduler-stats/pools/detail?pool={pool_name}&host={host_name}&backend={backend_name}&capabilities={capabilities}&share_type={share_type}"=>
  {:GET=>[:list_back_end_storage_pools_with_details]},
 "/v2/{tenant_id}/services?host={host}&binary={binary}&zone={zone}&state={state}&status={status}"=>
  {:GET=>[:list_services]},
 "/v2/{tenant_id}/services/enable"=>{:PUT=>[:enable_service]},
 "/v2/{tenant_id}/services/disable"=>{:PUT=>[:disable_service]},
 "/v2/{tenant_id}/availability-zones"=>{:GET=>[:list_availability_zones]},
 "/v2/{tenant_id}/os-share-manage"=>{:POST=>[:manage_share], :version => {:min => "2.0", :max => "2.6"}},
 "/v2/{tenant_id}/os-share-unmanage/{share_id}/unmanage"=>{:POST=> [:unmanage_share], :version => {:min => "2.0", :max => "2.6"}},
 "/v2/{tenant_id}/quota-sets/{tenant_id}/defaults"=>
  {:GET=>[:show_default_quota_set]},
 "/v2/{tenant_id}/quota-sets/{tenant_id}?user_id={user_id}"=>
  {:GET=>[:show_quota_set],
   :PUT=>[:update_quota_set],
   :DELETE=>[:delete_quota_set]},
 "/v2/{tenant_id}/quota-sets/{tenant_id}/detail?user_id={user_id}"=>
  {:GET=>[:show_quota_set_in_detail]},
 "/v2/{tenant_id}/consistency-groups"=>
  {:GET=>[:list_consistency_groups], :POST=>[:create_consistency_group]},
 "/v2/{tenant_id}/consistency-groups/detail"=>
  {:GET=>[:list_consistency_groups_with_details]},
 "/v2/{tenant_id}/consistency-groups/{consistency_group_id}"=>
  {:GET=>[:show_consistency_group_details],
   :PUT=>[:update_consistency_group],
   :DELETE=>[:delete_consistency_group]},
 "/v2/{tenant_id}/consistency-groups/{consistency_group_id}/action"=>
  {:POST=>[:reset_consistency_group_state, :force_delete_consistency_group]},
 "/v2/{tenant_id}/cgsnapshots"=>
  {:GET=>[:list_consistency_group_snapshots],
   :POST=>[:create_consistency_group_snapshot]},
 "/v2/{tenant_id}/cgsnapshots/detail"=>
  {:GET=>[:list_consistency_group_snapshots_with_details]},
 "/v2/{tenant_id}/cgsnapshots/{cgsnapshot_id}"=>
  {:GET=>[:show_consistency_group_snapshot_details],
   :PUT=>[:update_consistency_group_snapshot],
   :DELETE=>[:delete_consistency_group_snapshot]},
 "/v2/{tenant_id}/cgsnapshots/{cgsnapshot_id}/members"=>
  {:GET=>[:list_consistency_group_snapshot_members]},
 "/v2/{tenant_id}/cgsnapshots/{cgsnapshot_id}/action"=>
  {:POST=>
    [:reset_consistency_group_snapshot_state,
     :force_delete_consistency_group_snapshot]}}
  end
end
