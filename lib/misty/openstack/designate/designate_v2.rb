module Misty::Openstack::DesignateV2
  def v2
{"/"=>{:GET=>[:list_all_api_versions]},
 "/v2/zones"=>{:POST=>[:create_zone], :GET=>[:list_zones]},
 "/v2/zones/{zone_id}"=>
  {:GET=>[:show_a_zone], :PATCH=>[:update_a_zone], :DELETE=>[:delete_a_zone]},
 "/v2/zones/{zone_id}/nameservers"=>{:GET=>[:get_the_name_servers_for_a_zone]},
 "/v2/zones/tasks/imports"=>
  {:POST=>[:create_a_zone_import], :GET=>[:list_all_zone_imports]},
 "/v2/zones/tasks/imports/{zone_import_id}"=>
  {:GET=>[:show_a_zone_import], :DELETE=>[:delete_a_zone_import]},
 "/v2/zones/{zone_id}/tasks/export"=>{:POST=>[:create_a_zone_export]},
 "/v2/zones/tasks/exports"=>{:GET=>[:list_all_zone_exports]},
 "/v2/zones/tasks/exports/{zone_export_id}"=>
  {:GET=>[:show_a_zone_export_information], :DELETE=>[:delete_a_zone_export]},
 "/v2/zones/tasks/exports/{zone_export_id}/export"=>
  {:GET=>[:retrive_a_zone_export_from_the_designate_datastore]},
 "/v2/zones/{zone_id}/tasks/abandon"=>{:POST=>[:abandon_zone]},
 "/v2/zones/{zone_id}/tasks/xfr"=>
  {:POST=>[:manually_trigger_an_update_of_a_secondary_zone]},
 "/v2/zones/{zone_id}/tasks/transfer_requests"=>
  {:POST=>[:create_zone_transfer_request]},
 "/v2/zones/tasks/transfer_requests"=>{:GET=>[:list_zone_transfer_requests]},
 "/v2/zones/tasks/transfer_requests/{zone_transfer_request_id}"=>
  {:GET=>[:show_a_zone_transfer_request],
   :PATCH=>[:update_a_zone_transfer_request],
   :DELETE=>[:delete_a_zone_transfer_request]},
 "/v2/zones/tasks/transfer_accepts"=>
  {:POST=>[:create_zone_transfer_accept], :GET=>[:list_zone_transfer_accepts]},
 "/v2/zones/tasks/transfer_requests/{zone_transfer_accept_id}"=>
  {:GET=>[:get_zone_transfer_accept]},
 "/v2/zones/{zone_id}/recordsets"=>
  {:POST=>
    [:create_recordset,
     :create_a_mx_recordset,
     :create_a_sshfp_recordset,
     :create_a_spf_recordset,
     :create_a_srv_recordset],
   :GET=>[:list_recordsets_in_a_zone]},
 "/v2/recordsets"=>{:GET=>[:list_all_recordsets_owned_by_project]},
 "/v2/zones/{zone_id}/recordsets/{recordset_id}"=>
  {:GET=>[:show_a_recordset],
   :PUT=>[:update_a_recordset],
   :DELETE=>[:delete_a_recordset]},
 "/v2/pools"=>{:GET=>[:list_all_pools]},
 "/v2/pools/{pool_id}"=>{:GET=>[:show_a_pool]},
 "/v2/limits"=>{:GET=>[:get_project_limits]},
 "/v2/tlds"=>{:POST=>[:create_tld], :GET=>[:list_tlds]},
 "/v2/tlds/{tld_id}"=>
  {:GET=>[:show_tld], :PATCH=>[:update_tld], :DELETE=>[:delete_tld]},
 "/v2/tsigkeys"=>{:POST=>[:create_tsigkeys], :GET=>[:list_tsigkeys]},
 "/v2/tsigkeys/{tsigkey_id}"=>
  {:GET=>[:show_a_tsigkey],
   :PATCH=>[:update_tsigkey],
   :DELETE=>[:delete_a_tsigkey]},
 "/v2/blacklists"=>{:POST=>[:create_blacklist], :GET=>[:list_blacklists]},
 "/v2/blacklists/{blacklist_id}"=>
  {:GET=>[:show_blacklist],
   :PATCH=>[:update_blacklist],
   :DELETE=>[:delete_a_blacklist]},
 "/v2/quotas/{project_id}"=>
  {:GET=>[:view_quotas], :PATCH=>[:set_quotas], :DELETE=>[:reset_quotas]},
 "/v2/quotas/"=>{:GET=>[:view_current_project_s_quotas]},
 "/v2/service_status"=>{:GET=>[:list_statuses]},
 "/v2/reverse/floatingips/{region}:{floatingip_id}"=>
  {:PATCH=>[:set_floatingip_s_ptr_record, :unset_floatingip_s_ptr_record],
   :GET=>[:show_floatingip_s_ptr_record]},
 "/v2/reverse/floatingips"=>{:GET=>[:list_floatingip_s_ptr_record]}}
  end
end
