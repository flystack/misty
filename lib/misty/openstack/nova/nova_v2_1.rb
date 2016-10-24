module Misty::Openstack::NovaV2_1
  def v2_1
{"/"=>{:GET=>[:list_all_major_versions]},
 "/{api_version}"=>{:GET=>[:show_details_of_specific_api_version]},
 "/servers"=>
  {:GET=>[:list_servers], :POST=>[:create_server, :create_multiple_servers]},
 "/servers/detail"=>{:GET=>[:list_servers_detailed]},
 "/servers/{server_id}"=>
  {:GET=>[:show_server_details],
   :PUT=>[:update_server],
   :DELETE=>[:delete_server]},
 "/servers/{server_id}/action"=>
  {:POST=>
    [:add_associate_floating_ip_addfloatingip_action,
     :add_security_group_to_a_server_addsecuritygroup_action,
     :change_administrative_password_changepassword_action,
     :confirm_resized_server_confirmresize_action,
     :create_image_createimage_action,
     :lock_server_lock_action,
     :pause_server_pause_action,
     :reboot_server_reboot_action,
     :rebuild_server_rebuild_action,
     :remove_disassociate_floating_ip_removefloatingip_action,
     :remove_security_group_from_a_server_removesecuritygroup_action,
     :rescue_server_rescue_action,
     :resize_server_resize_action,
     :resume_suspended_server_resume_action,
     :revert_resized_server_revertresize_action,
     :start_server_os_start_action,
     :stop_server_os_stop_action,
     :suspend_server_suspend_action,
     :unlock_server_unlock_action,
     :unpause_server_unpause_action,
     :unrescue_server_unrescue_action,
     :add_associate_fixed_ip_addfixedip_action,
     :remove_disassociate_fixed_ip_removefixedip_action,
     :evacuate_server_evacuate_action,
     :force_delete_server_forcedelete_action,
     :restore_soft_deleted_instance_restore_action,
     :show_console_output_os_getconsoleoutput_action,
     :get_rdp_console_os_getrdpconsole_action,
     :get_serial_console_os_getserialconsole_action,
     :get_spice_console_os_getspiceconsole_action,
     :get_vnc_console_os_getvncconsole_action,
     :shelve_server_shelve_action,
     :shelf_offload_remove_server_shelveoffload_action,
     :unshelve_restore_shelved_server_unshelve_action,
     :trigger_crash_dump_in_server,
     :create_server_back_up_createbackup_action,
     :inject_network_information_injectnetworkinfo_action,
     :migrate_server_migrate_action,
     :live_migrate_server_os_migratelive_action,
     :reset_networking_on_a_server_resetnetwork_action,
     :reset_server_state_os_resetstate_action]},
 "/servers/{server_id}/os-security-groups"=>
  {:GET=>[:list_security_groups_by_server]},
 "/servers/{server_id}/diagnostics"=>{:GET=>[:show_server_diagnostics]},
 "/servers/{server_id}/ips"=>{:GET=>[:list_ips]},
 "/servers/{server_id}/ips/{network_label}"=>{:GET=>[:show_ip_details]},
 "/servers/{server_id}/metadata"=>
  {:GET=>[:list_all_metadata],
   :POST=>[:update_metadata_items],
   :PUT=>[:create_or_replace_metadata_items]},
 "/servers/{server_id}/metadata/{key}"=>
  {:GET=>[:show_metadata_item_details],
   :PUT=>[:create_or_update_metadata_item],
   :DELETE=>[:delete_metadata_item]},
 "/servers/{server_id}/os-instance-actions"=>
  {:GET=>[:list_actions_for_server]},
 "/servers/{server_id}/os-instance-actions/{request_id}"=>
  {:GET=>[:show_server_action_details]},
 "/servers/{server_id}/os-interface"=>
  {:GET=>[:list_port_interfaces], :POST=>[:create_interface]},
 "/servers/{server_id}/os-interface/{port_id}"=>
  {:GET=>[:show_port_interface_details], :DELETE=>[:detach_interface]},
 "/servers/{server_id}/os-server-password"=>
  {:GET=>[:show_server_password], :DELETE=>[:clear_admin_password]},
 "/servers/{server_id}/os-virtual-interfaces"=>
  {:GET=>[:list_virtual_interfaces]},
 "/servers/{server_id}/os-volume_attachments"=>
  {:GET=>[:list_volume_attachments_for_an_instance],
   :POST=>[:attach_a_volume_to_an_instance]},
 "/servers/{server_id}/os-volume_attachments/{attachment_id}"=>
  {:GET=>[:show_a_detail_of_a_volume_attachment],
   :PUT=>[:update_a_volume_attachment],
   :DELETE=>[:detach_a_volume_from_an_instance]},
 "/flavors"=>{:GET=>[:list_flavors], :POST=>[:create_flavor]},
 "/flavors/detail"=>{:GET=>[:list_flavors_with_details]},
 "/flavors/{flavor_id}"=>
  {:GET=>[:show_flavor_details], :DELETE=>[:delete_flavor]},
 "/flavors/{flavor_id}/os-flavor-access"=>
  {:GET=>[:list_flavor_access_information_for_given_flavor]},
 "/flavors/{flavor_id}/action"=>
  {:POST=>
    [:add_flavor_access_to_tenant_addtenantaccess_action,
     :remove_flavor_access_from_tenant_removetenantaccess_action]},
 "/flavors/{flavor_id}/os-extra_specs"=>
  {:GET=>[:list_extra_specs_for_a_flavor],
   :POST=>[:create_extra_specs_for_a_flavor]},
 "/flavors/{flavor_id}/os-extra_specs/{flavor_extra_spec_key}"=>
  {:GET=>[:show_an_extra_spec_for_a_flavor],
   :PUT=>[:update_an_extra_spec_for_a_flavor],
   :DELETE=>[:delete_an_extra_spec_for_a_flavor]},
 "/os-keypairs"=>{:GET=>[:list_keypairs], :POST=>[:create_or_import_keypair]},
 "/os-keypairs/{keypair_name}"=>
  {:GET=>[:show_keypair_details], :DELETE=>[:delete_keypair]},
 "/limits"=>{:GET=>[:show_rate_and_absolute_limits]},
 "/os-agents"=>{:GET=>[:list_agent_builds], :POST=>[:create_agent_build]},
 "/os-agents/{agent_build_id}"=>
  {:PUT=>[:update_agent_build], :DELETE=>[:delete_agent_build]},
 "/os-aggregates"=>{:GET=>[:list_aggregates], :POST=>[:create_aggregate]},
 "/os-aggregates/{aggregate_id}"=>
  {:GET=>[:show_aggregate_details],
   :PUT=>[:update_aggregate],
   :DELETE=>[:delete_aggregate]},
 "/os-aggregates/{aggregate_id}/action"=>
  {:POST=>[:add_host, :remove_host, :create_or_update_aggregate_metadata]},
 "/os-assisted-volume-snapshots"=>{:POST=>[:create_assisted_volume_snapshots]},
 "/os-assisted-volume-snapshots/{snapshot_id}"=>
  {:DELETE=>[:delete_assisted_volume_snapshot]},
 "/os-availability-zone"=>{:GET=>[:get_availability_zone_information]},
 "/os-availability-zone/detail"=>
  {:GET=>[:get_detailed_availability_zone_information]},
 "/os-cells"=>{:GET=>[:list_cells], :POST=>[:create_cell]},
 "/os-cells/capacities"=>{:GET=>[:capacities]},
 "/os-cells/detail"=>{:GET=>[:list_cells_with_details]},
 "/os-cells/info"=>{:GET=>[:info_for_this_cell]},
 "/os-cells/{cell_id}"=>{:GET=>[:show_cell_data], :DELETE=>[:delete_a_cell]},
 "/os-cells/{cell_od}"=>{:PUT=>[:update_a_cell]},
 "/os-cells/{cell_id}/capacities"=>{:GET=>[:show_cell_capacities]},
 "/servers/{server_id}/consoles"=>
  {:GET=>[:lists_consoles], :POST=>[:create_console]},
 "/servers/{server_id}/consoles/{console_id}"=>
  {:GET=>[:show_console_details], :DELETE=>[:delete_console]},
 "/os-console-auth-tokens/{console_token}"=>
  {:GET=>[:show_console_connection_information]},
 "/os-hosts"=>{:GET=>[:list_hosts]},
 "/os-hosts/{host_name}"=>
  {:GET=>[:show_host_details], :PUT=>[:update_host_status]},
 "/os-hosts/{host_name}/reboot"=>{:GET=>[:reboot_host]},
 "/os-hosts/{host_name}/shutdown"=>{:GET=>[:shut_down_host]},
 "/os-hosts/{host_name}/startup"=>{:GET=>[:start_host]},
 "/os-hypervisors"=>{:GET=>[:list_hypervisors]},
 "/os-hypervisors/detail"=>{:GET=>[:list_hypervisors_details]},
 "/os-hypervisors/statistics"=>{:GET=>[:show_hypervisor_statistics]},
 "/os-hypervisors/{hypervisor_id}"=>{:GET=>[:show_hypervisor_details]},
 "/os-hypervisors/{hypervisor_id}/uptime"=>{:GET=>[:show_hypervisor_uptime]},
 "/os-hypervisors/{hypervisor_hostname_pattern}/search"=>
  {:GET=>[:search_hypervisor]},
 "/os-hypervisors/{hypervisor_hostname_pattern}/servers"=>
  {:GET=>[:list_hypervisor_servers]},
 "/os-instance_usage_audit_log"=>{:GET=>[:list_server_usage_audits]},
 "/os-instance_usage_audit_log/{before_timestamp}"=>
  {:GET=>[:list_usage_audits_before_specified_time]},
 "/servers/{server_id}/migrations"=>{:GET=>[:list_migrations]},
 "/servers/{server_id}/migrations/{migration_id}"=>
  {:GET=>[:show_migration_details], :DELETE=>[:delete_abort_migration]},
 "/servers/{server_id}/migrations/{migration_id}/action"=>
  {:POST=>[:force_migration_complete_action_force_complete_action]},
 "/os-quota-sets/{tenant_id}"=>
  {:GET=>[:show_a_quota],
   :PUT=>[:update_quotas],
   :DELETE=>[:revert_quotas_to_defaults]},
 "/os-quota-sets/{tenant_id}/defaults"=>
  {:GET=>[:list_default_quotas_for_tenant]},
 "/os-quota-sets/{tenant_id}/detail"=>{:GET=>[:show_the_detail_of_quota]},
 "/os-server-groups"=>
  {:GET=>[:list_server_groups], :POST=>[:create_server_group]},
 "/os-server-groups/{server_group_id}"=>
  {:GET=>[:show_server_group_details], :DELETE=>[:delete_server_group]},
 "/servers/{server_id}/tags"=>
  {:GET=>[:list_tags], :PUT=>[:replace_tags], :DELETE=>[:delete_all_tags]},
 "/servers/{server_id}/tags/{tag}"=>
  {:GET=>[:check_tag_existence],
   :PUT=>[:add_a_single_tag],
   :DELETE=>[:delete_a_single_tag]},
 "/os-services"=>{:GET=>[:list_compute_services]},
 "/os-services/disable"=>{:PUT=>[:disable_scheduling_for_a_compute_service]},
 "/os-services/disable-log-reason"=>
  {:PUT=>[:log_disabled_compute_service_information]},
 "/os-services/enable"=>{:PUT=>[:enable_scheduling_for_a_compute_service]},
 "/os-services/force-down"=>{:PUT=>[:update_forced_down]},
 "/os-services/{service_id}"=>{:DELETE=>[:delete_compute_service]},
 "/os-simple-tenant-usage"=>
  {:GET=>[:list_tenant_usage_statistics_for_all_tenants]},
 "/os-simple-tenant-usage/{tenant_id}"=>
  {:GET=>[:show_usage_statistics_for_tenant]},
 "/os-server-external-events"=>{:POST=>[:run_events]},
 "/os-cloudpipe"=>{:GET=>[:list_cloudpipes], :POST=>[:create_cloudpipe]},
 "/os-cloudpipe/configure-project"=>{:PUT=>[:update_cloudpipe]},
 "/extensions"=>{:GET=>[:list_extensions]},
 "/extensions/{alias}"=>{:GET=>[:show_extension_details]},
 "/os-certificates"=>{:POST=>[:create_root_certificate]},
 "/os-certificates/root"=>{:GET=>[:show_root_certificate_details]},
 "/os-networks"=>{:GET=>[:list_networks], :POST=>[:create_network]},
 "/os-networks/add"=>{:POST=>[:add_network]},
 "/os-networks/{network_id}"=>
  {:GET=>[:show_network_details], :DELETE=>[:delete_network]},
 "/os-networks/{network_id}/action"=>
  {:POST=>
    [:associate_host_deprecated,
     :disassociate_network_deprecated,
     :disassociate_host_deprecated,
     :disassociate_project_deprecated]},
 "/os-volumes"=>{:GET=>[:list_volumes], :POST=>[:create_volume]},
 "/os-volumes/detail"=>{:GET=>[:list_volumes_with_details]},
 "/os-volumes/{volume_id}"=>
  {:GET=>[:show_volume_details], :DELETE=>[:delete_volume]},
 "/os-snapshots"=>{:GET=>[:list_snapshots], :POST=>[:create_snapshot]},
 "/os-snapshots/detail"=>{:GET=>[:list_snapshots_with_details]},
 "/os-snapshots/{snapshot_id}"=>
  {:GET=>[:show_snapshot_details], :DELETE=>[:delete_snapshot]},
 "/images"=>{:GET=>[:list_images]},
 "/images/detail"=>{:GET=>[:list_images_with_details]},
 "/images/{image_id}"=>{:GET=>[:show_image_details], :DELETE=>[:delete_image]},
 "/images/{image_id}/metadata"=>
  {:GET=>[:list_image_metadata],
   :POST=>[:create_image_metadata],
   :PUT=>[:update_image_metadata]},
 "/images/{image_id}/metadata/{key}"=>
  {:GET=>[:show_image_metadata_item],
   :PUT=>[:create_or_update_image_metadata_item],
   :DELETE=>[:delete_image_metadata_item]},
 "/os-baremetal-nodes"=>{:GET=>[:list_bare_metal_nodes]},
 "/os-baremetal-nodes/{node_id}"=>{:GET=>[:show_bare_metal_node_details]},
 "/os-tenant-networks"=>
  {:GET=>[:list_project_networks], :POST=>[:create_project_network]},
 "/os-tenant-networks/{network_id}"=>
  {:GET=>[:show_project_network_details], :DELETE=>[:delete_project_network]},
 "/os-fixed-ips/{fixed_ip}"=>{:GET=>[:show_fixed_ip_details]},
 "/os-fixed-ips/{fixed_ip}/action"=>{:POST=>[:reserve_or_release_a_fixed_ip]},
 "/os-floating-ip-dns"=>{:GET=>[:list_dns_domains]},
 "/os-floating-ip-dns/{domain}"=>
  {:PUT=>[:create_or_update_dns_domain], :DELETE=>[:delete_dns_domain]},
 "/os-floating-ip-dns/{domain}/entries/{ip}"=>{:GET=>[:list_dns_entries]},
 "/os-floating-ip-dns/{domain}/entries/{name}"=>
  {:GET=>[:find_unique_dns_entry],
   :PUT=>[:create_or_update_dns_entry],
   :DELETE=>[:delete_dns_entry]},
 "/os-floating-ip-pools"=>{:GET=>[:list_floating_ip_pools]},
 "/os-floating-ips"=>
  {:GET=>[:list_floating_ip_addresses],
   :POST=>[:create_allocate_floating_ip_address]},
 "/os-floating-ips/{floating_ip_id}"=>
  {:GET=>[:show_floating_ip_address_details],
   :DELETE=>[:delete_deallocate_floating_ip_address]},
 "/os-floating-ips-bulk"=>
  {:GET=>[:list_floating_ips], :POST=>[:create_floating_ips]},
 "/os-floating-ips-bulk/delete"=>{:PUT=>[:bulk_delete_floating_ips]},
 "/os-floating-ips-bulk/{host_name}"=>{:GET=>[:list_floating_ips_by_host]},
 "/os-fping"=>{:GET=>[:ping_instances]},
 "/os-fping/{instance_id}"=>{:GET=>[:ping_an_instance]},
 "/os-security-groups"=>
  {:GET=>[:list_security_groups], :POST=>[:create_security_group]},
 "/os-security-groups/{security_group_id}"=>
  {:GET=>[:show_security_group_details],
   :PUT=>[:update_security_group],
   :DELETE=>[:delete_security_group]},
 "/os-security-group-default-rules"=>
  {:GET=>[:list_default_security_group_rules],
   :POST=>[:create_default_security_group_rule]},
 "/os-security-group-default-rules/{security_group_default_rule_id}"=>
  {:GET=>[:show_default_security_group_rule_details],
   :DELETE=>[:delete_default_security_group_rule]},
 "/os-security-group-rules"=>{:POST=>[:create_security_group_rule]},
 "/os-security-group-rules/{security_group_rule_id}"=>
  {:DELETE=>[:delete_security_group_rule]}}
  end
end
