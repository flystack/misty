module Misty::Openstack::API::MonascaV2_0
  def tag
    'Monitoring API Manual v2.0'
  end

  def api
{"/"=>{:GET=>[:list_versions]},
 "/{version_id}"=>{:GET=>[:get_version]},
 "/v2.0/metrics"=>{:GET=>[:list_metrics]},
 "/v2.0/metrics/dimensions/names/values"=>{:GET=>[:list_dimension_values]},
 "/v2.0/metrics/dimensions/names"=>{:GET=>[:list_dimension_names]},
 "/v2.0/metrics/measurements"=>{:GET=>[:list_measurements]},
 "/v2.0/metrics/names"=>{:GET=>[:list_names]},
 "/v2.0/metrics/statistics"=>{:GET=>[:list_statistics]},
 "/v2.0/notification-methods"=>{:POST=>[:create_notification_method]},
 "/v2.0/notification-methods/{notification_method_id}"=>
  {:DELETE=>[:delete_notification_method]},
 "/v2.0/notification-methods/types/"=>
  {:GET=>[:list_supported_notification_method_types]},
 "/v2.0/alarm-definitions"=>{:GET=>[:list_alarm_definitions]},
 "/v2.0/alarm-definitions/{alarm_definition_id}"=>
  {:DELETE=>[:delete_alarm_definition]},
 "/v2.0/alarms"=>{:GET=>[:list_alarms]},
 "/v2.0/alarms/state-history"=>{:GET=>[:list_alarms_state_history]},
 "/v2.0/alarms/{alarm_id}"=>{:DELETE=>[:delete_alarm]},
 "/v2.0/alarms/{alarm_id}/state-history"=>{:GET=>[:list_alarm_state_history]}}
  end
end
