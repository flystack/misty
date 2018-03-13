module Misty::Openstack::API::GnocchiV1
  def tag
    'Metric API Manual v1'
  end

  def api
{"/v1/capabilities"=>{:GET=>[:list_capabilities]},
 "/v1/archive_policy"=>
  {:GET=>[:list_archive_policies], :POST=>[:create_archive_policies]},
 "/v1/archive_policy/{archive_policy}"=>
  {:DELETE=>[:delete_archive_policy],
   :GET=>[:get_archive_policy],
   :PATCH=>[:update_archive_policy]},
 "/v1/archive_policy_rule"=>
  {:GET=>[:list_archive_policy_rules], :POST=>[:create_archive_policy_rule]},
 "/v1/archive_policy_rule/{archive_policy_rule}"=>
  {:DELETE=>[:delete_archive_policy_rule],
   :GET=>[:get_archive_policy_rule],
   :PATCH=>[:update_archive_policy_rule]},
 "/v1/batch/metrics/measures"=>{:POST=>[:send_metrics_measures]},
 "/v1/metric"=>{:GET=>[:list_metrics], :POST=>[:create_metric]},
 "/v1/metric/{metric_id}"=>{:GET=>[:get_metric], :DELETE=>[:delete_metric]},
 "/v1/metric/{metric_id}/measures"=>
  {:GET=>[:get_metric_measures], :POST=>[:send_metric_measures]},
 "/v1/resource/generic"=>
  {:DELETE=>[:delete_resources], :POST=>[:create_ressource]},
 "/v1/resource/generic/{resource_id}/metric/{metric_name}/measures"=>
  {:GET=>[:get_resource_metric_measures]},
 "/v1/resource/generic/{resource_id}"=>
  {:GET=>[:get_resource], :DELETE=>[:delete_resource]},
 "/v1/resource/{resource_type}"=>
  {:DELETE=>[:delete_resource_type], :GET=>[:list_resource_type]},
 "/v1/resource_type"=>
  {:GET=>[:list_resource_types],
   :PATCH=>[:update_resource_type],
   :POST=>[:create_resource_type]},
 "/v1/status"=>{:GET=>[:get_status]}}
  end
end
