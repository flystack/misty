module Misty::Openstack::API::WatcherV1
  def tag
    'Web API'
  end

  def api
{"/v1/goal"=>{:GET=>[:list_goal]},
 "/v1/goal/{goal}"=>{:GET=>[:show_]},
 "/v1/goal/detail"=>{:GET=>[:list_detail]},
 "/v1/strategies"=>{:GET=>[:list_strategies]},
 "/v1/strategies/{strategy}"=>{:GET=>[:show_]},
 "/v1/strategies/detail"=>{:GET=>[:list_detail]},
 "/v1/strategies/state"=>{:GET=>[:list_state]},
 "/v1/audit_templates"=>
  {:GET=>[:list_audit_templates],
   :POST=>[:create_audit_templates],
   :DELETE=>[:delete_audit_templates]},
 "/v1/audit_templates/{audit_template}"=>{:GET=>[:show_]},
 "/v1/audit_templates/detail"=>{:GET=>[:list_detail]},
 "/v1/audits"=>
  {:GET=>[:list_audits], :POST=>[:create_audits], :DELETE=>[:delete_audits]},
 "/v1/audits/{audit}"=>{:GET=>[:show_]},
 "/v1/audits/detail"=>{:GET=>[:list_detail]},
 "/v1/action_plans"=>
  {:GET=>[:list_action_plans], :DELETE=>[:delete_action_plans]},
 "/v1/action_plans/{action_plan_uuid}"=>{:GET=>[:show_]},
 "/v1/action_plans/detail"=>{:GET=>[:list_detail]},
 "/v1/actions"=>
  {:GET=>[:list_actions],
   :POST=>[:create_actions],
   :DELETE=>[:delete_actions]},
 "/v1/actions/{action_uuid}"=>{:GET=>[:show_]},
 "/v1/actions/detail"=>{:GET=>[:list_detail]},
 "/v1/scoring_engine"=>{:GET=>[:list_scoring_engine]},
 "/v1/scoring_engine/{scoring_engine}"=>{:GET=>[:show_]},
 "/v1/scoring_engine/detail"=>{:GET=>[:list_detail]}}
  end
end
