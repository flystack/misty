module Misty::Openstack::HeatV1
  def v1
{"/v1/{tenant_id}/build_info"=>{:GET=>[:show_build_information]},
 "/"=>{:GET=>[:list_versions]},
 "/v1/{tenant_id}/stacks"=>
  {:POST=>[:create_stack, :adopt_stack], :GET=>[:list_stacks]},
 "/v1/{tenant_id}/stacks/preview"=>{:POST=>[:preview_stack]},
 "/v1/{tenant_id}/stacks/{stack_identity}"=>
  {:GET=>[:find_stack], :DELETE=>[:find_stack_for_deletion]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}"=>
  {:GET=>[:show_stack_details],
   :PUT=>[:update_stack],
   :PATCH=>[:update_stack_patch],
   :DELETE=>[:delete_stack]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/preview"=>
  {:PUT=>[:preview_stack_update], :PATCH=>[:preview_stack_update_patch]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/abandon"=>
  {:DELETE=>[:abandon_stack]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/export"=>
  {:GET=>[:export_stack]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/template"=>
  {:GET=>[:get_stack_template]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/environment"=>
  {:GET=>[:get_stack_environment]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/files"=>
  {:GET=>[:get_stack_files]},
 "/v1/{tenant_id}/stacks/{stack_identity}/resources"=>
  {:GET=>[:find_stack_resources]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources"=>
  {:GET=>[:list_stack_resources]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name}"=>
  {:GET=>[:show_resource_data]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name}/metadata"=>
  {:GET=>[:show_resource_metadata]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name}/signal"=>
  {:POST=>[:send_a_signal_to_a_resource]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name_or_physical_id}"=>
  {:PATCH=>[:mark_a_resource_as_unhealthy]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/outputs"=>
  {:GET=>[:list_outputs]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/outputs/{output_key}"=>
  {:GET=>[:show_output]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/snapshots"=>
  {:POST=>[:snapshot_a_stack], :GET=>[:list_snapshots]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/snapshots/{snapshot_id}"=>
  {:GET=>[:show_snapshot], :DELETE=>[:delete_a_snapshot]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/snapshots/{snapshot_id}/restore"=>
  {:POST=>[:restore_snapshot]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/actions"=>
  {:POST=>
    [:suspend_stack,
     :resume_stack,
     :cancel_stack_update,
     :check_stack_resources]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/events"=>
  {:GET=>[:list_stack_events]},
 "/v1/{tenant_id}/stacks/{stack_name}/events"=>{:GET=>[:find_stack_events]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name}/events"=>
  {:GET=>[:list_resource_events]},
 "/v1/{tenant_id}/stacks/{stack_name}/{stack_id}/resources/{resource_name}/events/{event_id}"=>
  {:GET=>[:show_event_details]},
 "/v1/{tenant_id}/template_versions"=>{:GET=>[:list_template_versions]},
 "/v1/{tenant_id}/template_versions/{template_version}/functions"=>
  {:GET=>[:list_template_functions]},
 "/v1/{tenant_id}/validate"=>{:POST=>[:validate_template]},
 "/v1/{tenant_id}/software_configs"=>
  {:POST=>[:create_configuration], :GET=>[:list_configs]},
 "/v1/{tenant_id}/software_configs/{config_id}"=>
  {:GET=>[:show_configuration_details], :DELETE=>[:delete_config]},
 "/v1/{tenant_id}/software_deployments"=>
  {:POST=>[:create_deployment], :GET=>[:list_deployments]},
 "/v1/{tenant_id}/software_deployments/{deployment_id}"=>
  {:GET=>[:show_deployment_details],
   :PUT=>[:update_deployment],
   :DELETE=>[:delete_deployment]},
 "/v1/{tenant_id}/software_deployments/metadata/{server_id}"=>
  {:GET=>[:show_server_configuration_metadata]},
 "/v1/{tenant_id}/resource_types"=>{:GET=>[:list_resource_types]},
 "/v1/{tenant_id}/resource_types/{type_name}/template"=>
  {:GET=>[:show_resource_type_template]},
 "/v1/{tenant_id}/resource_types/{type_name}"=>
  {:GET=>[:show_resource_type_schema]},
 "/v1/{tenant_id}/services"=>{:GET=>[:show_orchestration_engine_status]}}
  end
end
