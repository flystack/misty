module Misty::Openstack::SenlinV1
  def v1
{"/"=>{:GET=>[:list_major_versions]},
 "/{version}/"=>{:GET=>[:show_details_of_an_api_version]},
 "/v1/build-info"=>{:GET=>[:shows_build_information]},
 "/v1/profile-types"=>{:GET=>[:list_profile_types]},
 "/v1/profile-types/{profile_type}"=>{:GET=>[:show_profile_type_details]},
 "/v1/profile-types/{profile_type}/ops"=>
  {:GET=>[:list_profile_type_operations]},
 "/v1/profiles"=>{:GET=>[:list_profiles], :POST=>[:create_profile]},
 "/v1/profiles/{profile_id}"=>
  {:GET=>[:show_profile_details],
   :PATCH=>[:update_profile],
   :DELETE=>[:delete_profile]},
 "/v1/profiles/validate"=>{:POST=>[:validate_profile]},
 "/v1/policy-types"=>{:GET=>[:list_policy_types]},
 "/v1/policy-types/{policy_type}"=>{:GET=>[:show_policy_type_details]},
 "/v1/policies"=>{:GET=>[:list_policies], :POST=>[:create_policy]},
 "/v1/policies/{policy_id}"=>
  {:GET=>[:show_policy_details],
   :PATCH=>[:update_policy],
   :DELETE=>[:delete_policy]},
 "/v1/policies/validate"=>{:POST=>[:validate_policy]},
 "/v1/clusters"=>{:GET=>[:list_clusters], :POST=>[:create_cluster]},
 "/v1/clusters/{cluster_id}"=>
  {:GET=>[:show_cluster_details],
   :PATCH=>[:update_cluster],
   :DELETE=>[:delete_cluster]},
 "/v1/clusters/{cluster_id}/actions"=>
  {:POST=>
    [:resize_a_cluster,
     :scale_in_a_cluster,
     :scale_out_a_cluster,
     :add_nodes_to_a_cluster,
     :remove_nodes_from_a_cluster,
     :replace_nodes_in_a_cluster,
     :attach_a_policy_to_a_cluster,
     :detach_a_policy_from_a_cluster,
     :update_a_policy_on_a_cluster,
     :check_a_cluster_s_health_status,
     :recover_a_cluster_to_a_healthy_status]},
 "/v1/clusters/{cluster_id}/attrs/{path}"=>
  {:GET=>[:collect_attributes_across_a_cluster]},
 "/v1/clusters/{cluster_id}/ops"=>
  {:POST=>[:perform_an_operation_on_a_cluster]},
 "/v1/clusters/{cluster_id}/policies"=>{:GET=>[:list_all_cluster_policies]},
 "/v1/clusters/{cluster_id}/policies/{policy_id}"=>
  {:GET=>[:show_cluster_policy_details]},
 "/v1/nodes"=>{:GET=>[:list_nodes], :POST=>[:create_node]},
 "/v1/nodes/adopt"=>{:POST=>[:adopt_node]},
 "/v1/nodes/adopt-preview"=>{:POST=>[:adopt_node_preview]},
 "/v1/nodes/{node_id}"=>
  {:GET=>[:show_node_details],
   :PATCH=>[:update_node],
   :DELETE=>[:delete_node]},
 "/v1/nodes/{node_id}/actions"=>
  {:POST=>[:check_a_node_s_health, :recover_a_node_to_healthy_status]},
 "/v1/nodes/{node_id}/ops"=>{:POST=>[:perform_an_operation_on_a_node]},
 "/v1/receivers"=>{:GET=>[:list_receivers], :POST=>[:create_receiver]},
 "/v1/receivers/{receiver_id}"=>
  {:GET=>[:show_receiver_details],
   :PATCH=>[:update_receiver],
   :DELETE=>[:delete_receiver]},
 "/v1/events"=>{:GET=>[:list_events]},
 "/v1/events/{event_id}"=>{:GET=>[:shows_event_details]},
 "/v1/webhooks/{webhook_id}/trigger"=>{:POST=>[:trigger_webhook_action]},
 "/v1/actions"=>{:GET=>[:list_actions]},
 "/v1/actions/{action_id}"=>{:GET=>[:show_action_details]},
 "/v1/services"=>{:GET=>[:list_services]}}
  end
end
