module Misty::Openstack::CinderV1
  def tag
    'Block Storage API Legacy'
  end

  def api
{"/v1/{admin_tenant_id}/os-quota-sets/{tenant_id}/detail/{user_id}"=>
  {:GET=>[:show_quota_details_for_user_v1]},
 "/v1/{tenant_id}/os-quota-sets/defaults"=>{:GET=>[:show_default_quotas]},
 "/v1/{admin_tenant_id}/os-quota-sets/{tenant_id}"=>
  {:GET=>[:show_quotas_v1],
   :PUT=>[:update_quotas_v1],
   :DELETE=>[:delete_quotas_v1]},
 "/v1/{admin_tenant_id}/os-quota-sets/{tenant_id}/{user_id}"=>
  {:GET=>[:show_quotas_for_user_v1],
   :POST=>[:update_quotas_for_user_v1],
   :DELETE=>[:delete_quotas_for_user_v1]},
 "/v1/{tenant_id}/snapshots/{snapshot_id}"=>
  {:GET=>[:show_snapshot_details_v1], :DELETE=>[:delete_snapshot_v1]},
 "/v1/{tenant_id}/snapshots/detail"=>{:GET=>[:list_snapshots_with_details_v1]},
 "/v1/{tenant_id}/snapshots"=>
  {:POST=>[:create_snapshot_v1], :GET=>[:list_snapshots_v1]},
 "/v1/{tenant_id}/snapshots/{snapshot_id}/metadata"=>
  {:GET=>[:show_snapshot_metadata_v1], :PUT=>[:update_snapshot_metadata_v1]},
 "/v1/{tenant_id}/types"=>
  {:GET=>[:list_volume_types_v1], :POST=>[:create_volume_type_v1]},
 "/v1/{tenant_id}/types/{volume_type_id}"=>
  {:PUT=>[:update_volume_type_v1, :update_extra_specs_for_a_volume_type_v1],
   :GET=>[:show_volume_type_details_v1],
   :DELETE=>[:delete_volume_type_v1]},
 "/v1"=>{:GET=>[:show_api_v1_details]},
 "/"=>{:GET=>[:list_api_versions_v1]},
 "/v1/{tenant_id}/volumes/detail"=>{:GET=>[:list_volumes_with_details_v1]},
 "/v1/{tenant_id}/volumes"=>
  {:POST=>[:create_volume_v1], :GET=>[:list_volumes_v1]},
 "/v1/{tenant_id}/volumes/{volume_id}"=>
  {:GET=>[:show_volume_details_v1], :DELETE=>[:delete_volume_v1]}}
  end
end
