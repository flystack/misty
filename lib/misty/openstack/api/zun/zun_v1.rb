module Misty::Openstack::API::ZunV1
  def tag
    'Containers Service API Reference 1.0.1'
  end

  def api
{"/v1/containers/"=>
  {:POST=>[:create_new_container], :GET=>[:list_all_containers]},
 "/v1/containers/{container_ident}"=>
  {:GET=>[:show_details_of_a_container],
   :DELETE=>[:delete_a_container],
   :PATCH=>[:update_information_of_container]},
 "/v1/containers/{container_ident}/kill"=>{:POST=>[:kill_a_container]},
 "/v1/containers/{container_ident}/stats"=>
  {:GET=>[:display_stats_of_a_container]},
 "/v1/containers/{container_ident}/start"=>{:POST=>[:start_a_container]},
 "/v1/containers/{container_ident}/stop"=>{:POST=>[:stop_a_container]},
 "/v1/containers/{container_ident}/pause"=>{:POST=>[:pause_a_container]},
 "/v1/containers/{container_ident}/unpause"=>{:POST=>[:unpause_a_container]},
 "/v1/containers/{container_ident}/reboot"=>{:POST=>[:restart_a_container]},
 "/v1/containers/{container_ident}/rename"=>{:POST=>[:rename_a_container]},
 "/v1/containers/{container_ident}/get_archive"=>
  {:GET=>[:get_archive_from_a_container]},
 "/v1/containers/{container_ident}/put_archive"=>
  {:POST=>[:put_archive_to_a_container]},
 "/v1/containers/{container_ident}/add_securtiy_group"=>
  {:POST=>[:add_security_group_for_specified_container]},
 "/v1/containers/{container_ident}/commit"=>{:POST=>[:commit_a_container]},
 "/v1/containers/{container_ident}/attach"=>{:GET=>[:attach_to_a_container]},
 "/v1/containers/{container_ident}/network_detach"=>
  {:POST=>[:detach_a_network_from_a_container]},
 "/v1/containers/{container_ident}/resize"=>{:POST=>[:resize_a_container]},
 "/v1/containers/{container_ident}/network_attach"=>
  {:POST=>[:attach_a_network_to_a_container]},
 "/v1/containers/{container_ident}/execute"=>
  {:POST=>[:execute_command_in_a_running_container]},
 "/v1/containers/{container_ident}/execute_resize"=>
  {:POST=>[:resize_tty_when_execute_command_in_a_container]},
 "/v1/containers/{container_ident}/logs"=>{:GET=>[:get_logs_of_a_container]},
 "/v1/containers/{container_ident}/top"=>
  {:GET=>[:display_the_running_processes_in_a_container]},
 "/v1/containers/{container_ident}/network_list"=>
  {:GET=>[:list_networks_on_a_container]},
 "/v1/containers/{container_ident}/container_actions"=>
  {:GET=>[:list_actions_for_container]},
 "/v1/containers/{container_ident}/container_actions/{request_ident}"=>
  {:GET=>[:show_container_action_details]},
 "/v1/services"=>{:GET=>[:show_service_status], :DELETE=>[:delete_service]},
 "/v1/services/enable"=>{:PUT=>[:enable_service]},
 "/v1/services/disable"=>{:PUT=>[:disable_service]},
 "/v1/services/force_down"=>{:PUT=>[:force_down_service]},
 "/v1/hosts"=>{:GET=>[:list_all_compute_hosts]},
 "/v1/hosts/{host_ident}"=>{:GET=>[:show_details_of_a_host]}}
  end
end
