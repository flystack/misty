module Misty::Openstack::NeutronV2_0
  def v2_0
{"/"=>{:GET=>[:list_api_versions]},
 "/v2.0/"=>{:GET=>[:show_api_v2_details]},
 "/v2.0/extensions"=>{:GET=>[:list_extensions]},
 "/v2.0/extensions/{alias}"=>{:GET=>[:show_extension_details]},
 "/v2.0/networks/{network_id}"=>
  {:GET=>[:show_network_details],
   :PUT=>[:update_network],
   :DELETE=>[:delete_network]},
 "/v2.0/networks"=>
  {:GET=>[:list_networks], :POST=>[:create_network, :bulk_create_networks]},
 "/v2.0/ports/{port_id}"=>
  {:GET=>[:show_port_details, :show_trunk_details],
   :PUT=>[:update_port],
   :DELETE=>[:delete_port]},
 "/v2.0/ports"=>
  {:GET=>[:list_ports], :POST=>[:create_port, :bulk_create_ports]},
 "/v2.0/segments/{segment_id}"=>
  {:GET=>[:show_segment_details],
   :PUT=>[:update_segment],
   :DELETE=>[:delete_segment]},
 "/v2.0/segments"=>{:GET=>[:list_segments], :POST=>[:create_segment]},
 "/v2.0/trunks"=>{:GET=>[:list_trunks], :POST=>[:create_trunk]},
 "/v2.0/trunks/{trunk_id}/add_subports"=>{:PUT=>[:add_subports_to_trunk]},
 "/v2.0/trunks/{trunk_id}/remove_subports"=>
  {:PUT=>[:delete_subports_from_trunk]},
 "/v2.0/trunks/{trunk_id}/get_subports"=>{:GET=>[:list_subports_for_trunk]},
 "/v2.0/trunks/{trunk_id}"=>
  {:PUT=>[:update_trunk], :GET=>[:show_trunk], :DELETE=>[:delete_trunk]},
 "/v2.0/floatingips"=>
  {:GET=>[:list_floating_ips], :POST=>[:create_floating_ip]},
 "/v2.0/floatingips/{floatingip_id}"=>
  {:GET=>[:show_floating_ip_details],
   :PUT=>[:update_floating_ip],
   :DELETE=>[:delete_floating_ip]},
 "/v2.0/routers"=>{:GET=>[:list_routers], :POST=>[:create_router]},
 "/v2.0/routers/{router_id}"=>
  {:GET=>[:show_router_details],
   :PUT=>[:update_router],
   :DELETE=>[:delete_router]},
 "/v2.0/routers/{router_id}/add_router_interface"=>
  {:PUT=>[:add_interface_to_router]},
 "/v2.0/routers/{router_id}/remove_router_interface"=>
  {:PUT=>[:remove_interface_from_router]},
 "/v2.0/subnetpools/{subnetpool_id}"=>
  {:GET=>[:show_subnet_pool],
   :PUT=>[:update_subnet_pool],
   :DELETE=>[:delete_subnet_pool]},
 "/v2.0/subnetpools"=>
  {:GET=>[:list_subnet_pools], :POST=>[:create_subnet_pool]},
 "/v2.0/subnets"=>
  {:GET=>[:list_subnets], :POST=>[:create_subnet, :bulk_create_subnet]},
 "/v2.0/subnets/{subnet_id}"=>
  {:GET=>[:show_subnet_details],
   :PUT=>[:update_subnet],
   :DELETE=>[:delete_subnet]},
 "/v2.0/fw/firewall_policies"=>
  {:GET=>[:list_firewall_policies], :POST=>[:create_firewall_policy]},
 "/v2.0/fw/firewall_policies/{firewall_policy_id}"=>
  {:GET=>[:show_firewall_policy_details],
   :PUT=>[:update_firewall_policy],
   :DELETE=>[:delete_firewall_policy]},
 "/v2.0/fw/firewall_policies/{firewall_policy_id}/insert_rule"=>
  {:PUT=>[:insert_rule_into_a_firewall_policy]},
 "/v2.0/fw/firewall_policies/{firewall_policy_id}/remove_rule"=>
  {:PUT=>[:remove_rule_from_firewall_policy]},
 "/v2.0/fw/firewall_rules"=>
  {:GET=>[:list_firewall_rules], :POST=>[:create_firewall_rule]},
 "/v2.0/fw/firewall_rules/{firewall_rule_id}"=>
  {:GET=>[:show_firewall_rule_details],
   :PUT=>[:update_firewall_rule],
   :DELETE=>[:delete_firewall_rule]},
 "/v2.0/fw/firewalls"=>{:GET=>[:list_firewalls], :POST=>[:create_firewall]},
 "/v2.0/fw/firewalls/{firewall_id}"=>
  {:GET=>[:show_firewall_details],
   :PUT=>[:update_firewall],
   :DELETE=>[:delete_firewall]},
 "/v2.0/fwaas/firewall_groups"=>
  {:GET=>[:list_firewall_groups], :POST=>[:create_firewall_group]},
 "/v2.0/fwaas/firewall_groups/{firewall_group_id}"=>
  {:GET=>[:show_firewall_group_details],
   :PUT=>[:update_firewall_group],
   :DELETE=>[:delete_firewall_group]},
 "/v2.0/fwaas/firewall_policies"=>{:GET=>[:id250], :POST=>[:id258]},
 "/v2.0/fwaas/firewall_policies/{firewall_policy_id}"=>
  {:GET=>[:id254], :PUT=>[:id263], :DELETE=>[:id268]},
 "/v2.0/fwaas/firewall_rules"=>{:GET=>[:id271], :POST=>[:id279]},
 "/v2.0/fwaas/firewall_rules/{firewall_rule_id}"=>
  {:GET=>[:id275], :PUT=>[:id284], :DELETE=>[:id289]},
 "/v2.0/fwaas/firewall_policies/{firewall_policy_id}/insert_rule"=>
  {:PUT=>[:id291]},
 "/v2.0/fwaas/firewall_policies/{firewall_policy_id}/remove_rule"=>
  {:PUT=>[:id296]},
 "/v2.0/rbac-policies/{rbac_policy_id}"=>
  {:GET=>[:show_rbac_policy_details],
   :PUT=>[:update_rbac_policy],
   :DELETE=>[:delete_rbac_policy]},
 "/v2.0/rbac-policies"=>
  {:GET=>[:list_rbac_policies], :POST=>[:create_rbac_policy]},
 "/v2.0/security-group-rules"=>
  {:GET=>[:list_security_group_rules], :POST=>[:create_security_group_rule]},
 "/v2.0/security-group-rules/{security_group_rule_id}"=>
  {:GET=>[:show_security_group_rule], :DELETE=>[:delete_security_group_rule]},
 "/v2.0/security-groups"=>
  {:GET=>[:list_security_groups], :POST=>[:create_security_group]},
 "/v2.0/security-groups/{security_group_id}"=>
  {:GET=>[:show_security_group],
   :PUT=>[:update_security_group],
   :DELETE=>[:delete_security_group]},
 "/v2.0/vpn/ikepolicies"=>
  {:GET=>[:list_ike_policies], :POST=>[:create_ike_policy]},
 "/v2.0/vpn/ikepolicies/{ikepolicy_id}"=>
  {:GET=>[:show_ike_policy_details],
   :PUT=>[:update_ike_policy],
   :DELETE=>[:remove_ike_policy]},
 "/v2.0/vpn/ipsecpolicies"=>
  {:GET=>[:list_ipsec_policies], :POST=>[:create_ipsec_policy]},
 "/v2.0/vpn/ipsecpolicies/{ipsecpolicy_id}"=>
  {:GET=>[:show_ipsec_policy],
   :PUT=>[:update_ipsec_policy],
   :DELETE=>[:remove_ipsec_policy]},
 "/v2.0/vpn/ipsec-site-connections"=>
  {:GET=>[:list_ipsec_connections], :POST=>[:create_ipsec_connection]},
 "/v2.0/vpn/ipsec-site-connections/{connection_id}"=>
  {:GET=>[:show_ipsec_connection],
   :PUT=>[:update_ipsec_connection],
   :DELETE=>[:remove_ipsec_connection]},
 "/v2.0/vpn/endpoint-groups"=>
  {:GET=>[:list_vpn_endpoint_groups], :POST=>[:create_vpn_endpoint_group]},
 "/v2.0/vpn/endpoint-groups/{endpoint_group_id}"=>
  {:GET=>[:show_vpn_endpoint_group],
   :PUT=>[:update_vpn_endpoint_group],
   :DELETE=>[:remove_vpn_endpoint_group]},
 "/v2.0/vpn/vpnservices"=>
  {:GET=>[:list_vpn_services], :POST=>[:create_vpn_service]},
 "/v2.0/vpn/vpnservices/{service_id}"=>
  {:GET=>[:show_vpn_service_details],
   :PUT=>[:update_vpn_service],
   :DELETE=>[:remove_vpn_service]},
 "/v2.0/flavors"=>{:GET=>[:list_flavors], :POST=>[:create_flavor]},
 "/v2.0/flavors/{flavor_id}"=>
  {:GET=>[:show_flavor_details],
   :PUT=>[:update_flavor],
   :DELETE=>[:delete_flavor]},
 "/v2.0/flavors/{flavor_id}/service_profiles"=>
  {:POST=>[:associate_flavor_with_a_service_profile]},
 "/v2.0/flavors/{flavor_id}/service_profiles/{profile_id}"=>
  {:DELETE=>[:disassociate_a_flavor]},
 "/v2.0/service_profiles"=>
  {:GET=>[:list_service_profiles], :POST=>[:create_service_profile]},
 "/v2.0/service_profiles/{profile_id}"=>
  {:GET=>[:show_service_profile_details],
   :PUT=>[:update_service_profile],
   :DELETE=>[:delete_service_profile]},
 "/v2.0/metering/metering-labels"=>
  {:GET=>[:list_metering_labels], :POST=>[:create_metering_label]},
 "/v2.0/metering/metering-labels/{metering_label_id}"=>
  {:GET=>[:show_metering_label_details], :DELETE=>[:delete_metering_label]},
 "/v2.0/metering/metering-label-rules"=>
  {:GET=>[:list_metering_label_rules], :POST=>[:create_metering_label_rule]},
 "/v2.0/metering/metering-label-rules/{metering_label_rule_id}"=>
  {:GET=>[:show_metering_label_rule_details],
   :DELETE=>[:delete_metering_label_rule]},
 "/v2.0/network-ip-availabilities/{network_id}"=>
  {:GET=>[:show_network_ip_availability]},
 "/v2.0/network-ip-availabilities"=>{:GET=>[:list_network_ip_availability]},
 "/v2.0/quotas"=>
  {:GET=>[:list_quotas_for_projects_with_non_default_quota_values]},
 "/v2.0/quotas/{project_id}"=>
  {:GET=>[:list_quotas_for_a_project],
   :PUT=>[:update_quota_for_a_project],
   :DELETE=>[:reset_quota_for_a_project]},
 "/v2.0/quotas/{project_id}/default"=>
  {:GET=>[:list_default_quotas_for_a_project]},
 "/v2.0/service-providers"=>{:GET=>[:list_service_providers]},
 "/v2.0/{resource_type}/{resource_id}/tags"=>
  {:PUT=>[:replace_all_tags],
   :DELETE=>[:remove_all_tags],
   :GET=>[:obtain_tag_list]},
 "/v2.0/{resource_type}/{resource_id}/tags/{tag}"=>
  {:GET=>[:confirm_a_tag], :PUT=>[:add_a_tag], :DELETE=>[:remove_a_tag]},
 "/v2.0/qos/rule-types"=>{:GET=>[:list_qos_rule_types]},
 "/v2.0/qos/policies"=>
  {:GET=>[:list_qos_policies], :POST=>[:create_qos_policy]},
 "/v2.0/qos/policies/{policy_id}"=>
  {:GET=>[:show_qos_policy_details],
   :PUT=>[:update_qos_policy],
   :DELETE=>[:delete_qos_policy]},
 "/v2.0/qos/policies/{policy_id}/bandwidth_limit_rules"=>
  {:GET=>[:list_bandwidth_limit_rules_for_qos_policy],
   :POST=>[:create_bandwidth_limit_rule]},
 "/v2.0/qos/policies/{policy_id}/bandwidth_limit_rules/{rule_id}"=>
  {:GET=>[:show_bandwidth_limit_rule_details],
   :PUT=>[:update_bandwidth_limit_rule],
   :DELETE=>[:delete_bandwidth_limit_rule]},
 "/v2.0/qos/policies/{policy_id}/dscp_marking_rules"=>
  {:GET=>[:list_dscp_marking_rules_for_qos_policy],
   :POST=>[:create_dscp_marking_rule]},
 "/v2.0/qos/policies/{policy_id}/dscp_marking_rules/{dscp_rule_id}"=>
  {:GET=>[:show_dscp_marking_rule_details],
   :PUT=>[:update_dscp_marking_rule],
   :DELETE=>[:delete_dscp_marking_rule]},
 "/v2.0/lb/pools"=>
  {:GET=>[:list_pools], :POST=>[:create_a_load_balancer_pool]},
 "/v2.0/lb/pools/{pool_id}"=>
  {:GET=>[:show_pool_details], :PUT=>[:update_pool], :DELETE=>[:delete_pool]},
 "/v2.0/lb/vips"=>{:GET=>[:list_vips], :POST=>[:create_a_load_balancer_vip]},
 "/v2.0/lb/vips/{vip_id}"=>
  {:GET=>[:show_vip_details], :PUT=>[:update_vip], :DELETE=>[:delete_vip]},
 "/v2.0/lb/members"=>
  {:GET=>[:list_members], :POST=>[:create_a_load_balancer_member]},
 "/v2.0/lb/members/{member_id}"=>
  {:GET=>[:show_member_details],
   :PUT=>[:update_member],
   :DELETE=>[:delete_member]},
 "/v2.0/lb/health_monitors"=>
  {:GET=>[:list_health_monitors],
   :POST=>[:create_a_load_balancer_health_monitor]},
 "/v2.0/lb/health_monitors/{health_monitor_id}"=>
  {:GET=>[:show_health_monitor_details],
   :PUT=>[:update_health_monitor],
   :DELETE=>[:delete_health_monitor]},
 "/v2.0/lb/pools/{pool_id}/health_monitors"=>
  {:POST=>[:associate_health_monitor_with_pool]},
 "/v2.0/lb/pools/{pool_id}/health_monitors/{health_monitor_id}"=>
  {:DELETE=>[:disassociate_health_monitor_from_pool]},
 "/v2.0/lbaas/loadbalancers"=>
  {:GET=>[:list_load_balancers], :POST=>[:create_a_load_balancer]},
 "/v2.0/lbaas/loadbalancers/{loadbalancer_id}"=>
  {:GET=>[:show_load_balancer_details],
   :PUT=>[:update_load_balancer],
   :DELETE=>[:remove_load_balancer]},
 "/v2.0/lbaas/loadbalancers/{loadbalancer_id}/statuses"=>
  {:GET=>[:show_load_balancer_status_tree]},
 "/v2.0/lbaas/listeners"=>{:GET=>[:list_listeners], :POST=>[:create_listener]},
 "/v2.0/lbaas/listeners/{listener_id}"=>
  {:GET=>[:show_listener_details],
   :PUT=>[:update_listener],
   :DELETE=>[:remove_listener]},
 "/v2.0/lbaas/pools"=>{:GET=>[:id686], :POST=>[:create_pool]},
 "/v2.0/lbaas/pools/{pool_id}"=>
  {:GET=>[:id694], :PUT=>[:id698], :DELETE=>[:remove_pool]},
 "/v2.0/lbaas/pools/{pool_id}/members"=>
  {:GET=>[:list_pool_members], :POST=>[:add_member_to_pool]},
 "/v2.0/lbaas/pools/{pool_id}/members/{member_id}"=>
  {:GET=>[:show_pool_member_details],
   :PUT=>[:update_pool_member],
   :DELETE=>[:remove_member_from_pool]},
 "/v2.0/lbaas/healthmonitors"=>{:GET=>[:id721]},
 "/v2.0/lbaas/health_monitors"=>{:POST=>[:create_health_monitor]},
 "/v2.0/lbaas/health_monitors/{health_monitor_id}"=>
  {:GET=>[:id729], :PUT=>[:id733], :DELETE=>[:remove_health_monitor]},
 "/v2.0/logging/logging_resources"=>
  {:GET=>[:list_logging_resources], :POST=>[:create_logging_resource]},
 "/v2.0/logging/logging_resources/{logging_resource_id}"=>
  {:GET=>[:show_logging_resource_details],
   :PUT=>[:update_logging_resource],
   :DELETE=>[:delete_logging_resource]},
 "/v2.0/logging/logging_resources/{logging_resource_id}/firewall_logs"=>
  {:GET=>[:list_firewall_logs], :POST=>[:create_firewall_log]},
 "/v2.0/logging/logging_resources/{logging_resource_id}/firewall_logs/{firewall_log_id}"=>
  {:GET=>[:show_firewall_log_details],
   :PUT=>[:update_firewall_log],
   :DELETE=>[:delete_firewall_log]},
 "/v2.0/bgpvpn/bgpvpns"=>{:GET=>[:list_bgp_vpns], :POST=>[:create_bgp_vpns]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}"=>
  {:GET=>[:show_bgp_vpn_details],
   :PUT=>[:update_a_bgp_vpn],
   :DELETE=>[:delete_bgp_vpn]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/network_associations"=>
  {:GET=>[:list_network_associations], :POST=>[:create_network_association]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/network_associations/{network_association_id}"=>
  {:GET=>[:show_network_association_details],
   :DELETE=>[:delete_network_association]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/router_associations"=>
  {:GET=>[:list_router_associations], :POST=>[:create_router_association]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/router_associations/{router_association_id}"=>
  {:GET=>[:show_router_association_details],
   :PUT=>[:update_a_router_association_bgpvpn_routes_control_extension],
   :DELETE=>[:delete_router_association]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/port_associations"=>
  {:GET=>[:list_port_associations], :POST=>[:create_port_association]},
 "/v2.0/bgpvpn/bgpvpns/{bgpvpn_id}/port_associations/{port_association_id}"=>
  {:GET=>[:show_port_association_details],
   :PUT=>[:update_a_port_association],
   :DELETE=>[:delete_port_association]},
 "/v2.0/log/logs"=>{:GET=>[:list_logs], :POST=>[:create_log]},
 "/v2.0/log/logs/{log_id}"=>
  {:GET=>[:show_log], :PUT=>[:update_log], :DELETE=>[:delete_log]},
 "/v2.0/log/loggable-resources"=>{:GET=>[:list_loggable_resources]}}
  end
end
