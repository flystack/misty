module Misty::Openstack::AodhV2
  def api
{"/v2/capabilities"=>{:GET=>[:list_capabilities]},
 "/v2/alarms"=>{:GET=>[:list_alarms], :POST=>[:create_alarm]},
 "/v2/alarms/{alarm_id}"=>
  {:GET=>[:show_alarm], :PUT=>[:"update_alarm}"], :DELETE=>[:delete_alarm]},
 "/v2/alarms/{alarm_id}/history"=>{:GET=>[:show_alarm_history]},
 "/v2/alarms/{alarm_id}/state"=>{:GET=>[:show_alarm_state], :PUT=>[:"update_alarm_state}"]},
 "/v2/query/alarms"=>{:POST=>[:create_alarms_query]},
 "/v2/query/alarms/history"=>{:POST=>[:create_alarm_query_history]}}
  end
end
