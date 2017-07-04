module Misty::Openstack::OctaviaV2_0
  def v2_0
{"/v2.0/lbaas/loadbalancers"=>
  {:GET=>[:list_load_balancers], :POST=>[:create_a_load_balancer]},
 "/v2.0/lbaas/loadbalancers/{loadbalancer_id}"=>
  {:GET=>[:show_load_balancer_details],
   :PUT=>[:update_a_load_balancer],
   :DELETE=>[:remove_a_load_balancer]},
 "/v2.0/lbaas/loadbalancers/{loadbalancer_id}/stats"=>
  {:GET=>[:get_load_balancer_statistics]},
 "/v2.0/lbaas/loadbalancers/{loadbalancer_id}/status"=>
  {:GET=>[:get_the_load_balancer_status_tree]},
 "/v2.0/lbaas/listeners"=>{:GET=>[:list_listeners], :POST=>[:create_listener]},
 "/v2.0/lbaas/listeners/{listener_id}"=>
  {:GET=>[:show_listener_details],
   :PUT=>[:update_a_listener],
   :DELETE=>[:remove_a_listener]},
 "/v2.0/lbaas/listeners/{listener_id}/stats"=>
  {:GET=>[:get_listener_statistics]},
 "/v2.0/lbaas/pools"=>{:GET=>[:list_pools], :POST=>[:create_pool]},
 "/v2.0/lbaas/pools/{pool_id}"=>
  {:GET=>[:show_pool_details],
   :PUT=>[:update_a_pool],
   :DELETE=>[:remove_a_pool]},
 "/v2.0/lbaas/pools/{pool_id}/members"=>
  {:GET=>[:list_members], :POST=>[:create_member]},
 "/v2.0/lbaas/pools/{pool_id}/members/{member-id}"=>
  {:GET=>[:show_member_details]},
 "/v2.0/lbaas/pools/{pool_id}/members/{member_id}"=>
  {:PUT=>[:update_a_member], :DELETE=>[:remove_a_member]},
 "/v2.0/lbaas/healthmonitors"=>
  {:GET=>[:list_health_monitors], :POST=>[:create_health_monitor]},
 "/v2.0/lbaas/healthmonitors/{healthmonitor_id}"=>
  {:GET=>[:show_health_monitor_details],
   :PUT=>[:update_a_health_monitor],
   :DELETE=>[:remove_a_health_monitor]},
 "/v2.0/lbaas/l7policies"=>
  {:GET=>[:list_l7_policies], :POST=>[:create_an_l7_policy]},
 "/v2.0/lbaas/l7policies/{l7policy_id}"=>
  {:GET=>[:show_l7_policy_details],
   :PUT=>[:update_a_l7_policy],
   :DELETE=>[:remove_a_l7_policy]},
 "/v2.0/lbaas/l7policies/{l7policy_id}/rules"=>
  {:GET=>[:list_l7_rules], :POST=>[:create_an_l7_rule]},
 "/v2.0/lbaas/l7policies/{l7policy_id}/rules/{l7rule_id}"=>
  {:GET=>[:show_l7_rule_details],
   :PUT=>[:update_a_l7_rule],
   :DELETE=>[:remove_a_l7_rule]},
 "/v2.0/lbaas/quotas"=>{:GET=>[:list_quota]},
 "/v2.0/lbaas/quotas/defaults"=>{:GET=>[:show_quota_defaults]},
 "/v2.0/lbaas/quotas/{project_id}"=>
  {:GET=>[:show_project_quota],
   :PUT=>[:update_a_quota],
   :DELETE=>[:remove_a_quota]}}
  end
end
