module Misty::Openstack::GlanceV1
  def v1
{"/v1/images"=>{:POST=>[:create_image], :GET=>[:list_images]},
 "/v1/images/detail"=>{:GET=>[:list_images_with_details]},
 "/v1/images/{image_id}"=>
  {:PUT=>[:update_image],
   :GET=>[:show_image_details_and_image_data],
   :HEAD=>[:show_image_metadata],
   :DELETE=>[:delete_image]},
 "/v1/images/{image_id}/members/{member_id}"=>
  {:PUT=>[:add_member_to_image], :DELETE=>[:remove_member]},
 "/v1/images/{image_id}/members"=>
  {:PUT=>[:replace_membership_list_for_an_image]},
 "/v1/shared-images/{owner_id}"=>{:GET=>[:list_shared_images]}}
  end
end
