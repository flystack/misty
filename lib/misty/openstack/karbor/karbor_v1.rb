module Misty::Openstack::KarborV1
  def v1
{"/v1/{tenant_id}/protectables"=>{:GET=>[:list_protectable_types]},
 "/v1/{tenant_id}/protectables/{protectable_type}"=>
  {:GET=>[:show_protectable_type]},
 "/v1/{tenant_id}/protectables/{protectable_type}/instances"=>
  {:GET=>[:list_protectable_instances]},
 "/v1/{tenant_id}/protectables/{protectable_type}/instances/{resource_id}"=>
  {:GET=>[:show_protectable_instance]},
 "/v1/{tenant_id}/providers"=>{:GET=>[:list_protection_providers]},
 "/v1/{tenant_id}/providers/{provider_id}"=>
  {:GET=>[:show_protection_provider]},
 "/v1/{tenant_id}/plans"=>{:GET=>[:list_plans], :POST=>[:create_plan]},
 "/v1/{tenant_id}/plans/{plan_id}"=>
  {:GET=>[:show_plan], :PUT=>[:update_plan], :DELETE=>[:delete_plan]},
 "/v1/{tenant_id}/triggers"=>
  {:GET=>[:list_triggers], :POST=>[:create_trigger]},
 "/v1/{tenant_id}/triggers/{trigger_id}"=>
  {:GET=>[:show_trigger], :PUT=>[:update_trigger], :DELETE=>[:delete_trigger]},
 "/v1/{tenant_id}/scheduled_operations"=>
  {:GET=>[:list_scheduled_operations], :POST=>[:create_scheduled_operation]},
 "/v1/{tenant_id}/scheduled_operations/{scheduled_operation_id}"=>
  {:GET=>[:show_scheduled_operation], :DELETE=>[:delete_scheduled_operation]},
 "/v1/{tenant_id}/providers/{provider_id}/checkpoints"=>
  {:GET=>[:list_checkpoints], :POST=>[:create_checkpoint]},
 "/v1/{tenant_id}/providers/{provider_id}/checkpoints/{checkpoint_id}"=>
  {:GET=>[:show_checkpoint], :DELETE=>[:delete_checkpoint]},
 "/v1/{tenant_id}/restores"=>
  {:GET=>[:list_restores], :POST=>[:create_restore]},
 "/v1/{tenant_id}/restores/{restore_id}"=>{:GET=>[:show_restore]}}
  end
end
