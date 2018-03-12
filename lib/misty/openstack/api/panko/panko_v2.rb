module Misty::Openstack::API::PankoV2
  def tag
    'Event API Manual v2'
  end

  def api
{"/v2/capabilities"=>{:GET=>[:list_capabilities]},
 "/v2/event_types"=>{:GET=>[:list_event_types]},
 "/v2/event_types/{event_type}/traits"=>{:GET=>[:list_event_types_traits]},
 "/v2/event_types/{event_type}/traits/{event_type}"=>{:GET=>[:list_traits]},
 "/v2/events"=>{:GET=>[:list_events]},
 "/v2/events/{message_id}"=>{:GET=>[:get_event]}}
  end
end
