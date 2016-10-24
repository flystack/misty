module Misty::Openstack::SwiftV1
  def v1
{"/info"=>{:GET=>[:list_activated_capabilities]},
 "/v1/{account}"=>
  {:GET=>[:show_account_details_and_list_containers],
   :POST=>[:create_update_or_delete_account_metadata],
   :HEAD=>[:show_account_metadata]},
 "/v1/{account}/{container}"=>
  {:GET=>[:show_container_details_and_list_objects],
   :PUT=>[:create_container],
   :POST=>[:create_update_or_delete_container_metadata],
   :HEAD=>[:show_container_metadata],
   :DELETE=>[:delete_container]},
 "/v1/{account}/{container}/{object}"=>
  {:GET=>[:get_object_content_and_metadata],
   :PUT=>[:create_or_replace_object],
   :COPY=>[:copy_object],
   :DELETE=>[:delete_object],
   :HEAD=>[:show_object_metadata],
   :POST=>[:create_or_update_object_metadata]},
 "/v1/endpoints"=>{:GET=>[:list_endpoints]}}
  end
end
