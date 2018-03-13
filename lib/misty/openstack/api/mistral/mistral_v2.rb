module Misty::Openstack::API::MistralV2
  def tag
    'Web API'
  end

  def api
{"/v2/workbooks"=>
  {:GET=>[:list_workbooks],
   :PUT=>[:create_workbooks],
   :POST=>[:create_workbooks],
   :DELETE=>[:delete_workbooks]},
 "/v2/workflows"=>
  {:GET=>[:list_workflows],
   :PUT=>[:create_workflows],
   :POST=>[:create_workflows],
   :DELETE=>[:delete_workflows]},
 "/v2/actions"=>
  {:GET=>[:list_actions],
   :PUT=>[:create_actions],
   :POST=>[:create_actions],
   :DELETE=>[:delete_actions]},
 "/v2/executions"=>
  {:GET=>[:list_executions],
   :PUT=>[:create_executions],
   :POST=>[:create_executions],
   :DELETE=>[:delete_executions]},
 "/v2/tasks"=>{:GET=>[:list_tasks], :PUT=>[:create_tasks]},
 "/v2/action_executions"=>
  {:GET=>[:list_action_executions],
   :PUT=>[:create_action_executions],
   :POST=>[:create_action_executions],
   :DELETE=>[:delete_action_executions]},
 "/v2/cron_triggers"=>
  {:GET=>[:list_cron_triggers],
   :POST=>[:create_cron_triggers],
   :DELETE=>[:delete_cron_triggers]},
 "/v2/environments"=>
  {:GET=>[:list_environments],
   :PUT=>[:create_environments],
   :POST=>[:create_environments],
   :DELETE=>[:delete_environments]},
 "/v2/services"=>{:GET=>[:list_services]}}
  end
end
