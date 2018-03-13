module Misty::Openstack::API::MasakariV1_0
  def tag
    'Masakari API Reference 5.0.0'
  end

  def api
{"/"=>{:GET=>[:list_all_major_versions]},
 "/{api_version}/"=>{:GET=>[:show_details_of_specific_api_version]},
 "/segments"=>{:GET=>[:list_failoversegments], :POST=>[:create_segment]},
 "/segments/{segment_id}"=>
  {:GET=>[:show_segment_details],
   :PUT=>[:update_segment],
   :DELETE=>[:delete_segment]},
 "/segments/{segment_id}/hosts"=>{:GET=>[:list_hosts], :POST=>[:create_host]},
 "/segments/{segment_id}/hosts/{host_id}"=>{:GET=>[:show_host_details]},
 "/segments/{segment_id}hosts/{host_id}"=>
  {:PUT=>[:update_host], :DELETE=>[:delete_host]},
 "/notifications"=>
  {:GET=>[:list_notifications], :POST=>[:create_notification]},
 "/notifications/{notification_id}"=>{:GET=>[:show_notification_details]}}
  end
end
