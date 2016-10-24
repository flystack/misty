module Misty::Openstack::GlanceV2
  def v2
{"/v2/images"=>{:POST=>[:create_an_image], :GET=>[:show_images]},
 "/v2/images/{image_id}"=>
  {:GET=>[:show_image_details],
   :PATCH=>[:update_an_image],
   :DELETE=>[:delete_an_image]},
 "/v2/images/{image_id}/actions/deactivate"=>{:POST=>[:deactivate_image]},
 "/v2/images/{image_id}/actions/reactivate"=>{:POST=>[:reactivate_image]},
 "/v2/images/{image_id}/members"=>
  {:POST=>[:create_image_member], :GET=>[:list_image_members]},
 "/v2/images/{image_id}/members/{member_id}"=>
  {:GET=>[:show_image_member_details],
   :PUT=>[:update_image_member],
   :DELETE=>[:delete_image_member]},
 "/v2/images/{image_id}/tags/{tag}"=>
  {:PUT=>[:add_image_tag], :DELETE=>[:delete_image_tag]},
 "/v2/schemas/images"=>{:GET=>[:show_images_schema]},
 "/v2/schemas/image"=>{:GET=>[:show_image_schema]},
 "/v2/schemas/members"=>{:GET=>[:show_image_members_schema]},
 "/v2/schemas/member"=>{:GET=>[:show_image_member_schema]},
 "/v2/images/{image_id}/file"=>
  {:PUT=>[:upload_binary_image_data], :GET=>[:download_binary_image_data]},
 "/v2/tasks"=>{:POST=>[:create_task], :GET=>[:list_tasks]},
 "/v2/tasks/{task_id}"=>{:GET=>[:show_task_details]},
 "/v2/schemas/tasks"=>{:GET=>[:show_tasks_schema]},
 "/v2/schemas/task"=>{:GET=>[:show_task_schema]}}
  end
end
