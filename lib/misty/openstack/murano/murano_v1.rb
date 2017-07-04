module Misty::Openstack::MuranoV1
  def v1
{"/environments/{environment_id}/actions/{action_id}"=>
  {:POST=>[:execute_action]},
 "/environments/{environment_id}/actions/{task_id}"=>
  {:GET=>[:get_action_result]},
 "/actions"=>{:POST=>[:execute_static_action]},
 "/catalog/categories"=>{:GET=>[:list_categories], :POST=>[:create_category]},
 "/catalog/categories/{category_id}"=>
  {:GET=>[:show_category_details], :DELETE=>[:delete_category]},
 "/deployments"=>{:GET=>[:list_deployments]},
 "/environments"=>{:GET=>[:list_environments], :POST=>[:create_environment]},
 "/environments/{env_id}"=>
  {:PUT=>[:rename_environment],
   :GET=>[:show_environment_details],
   :DELETE=>[:delete_environment]},
 "/environments/{env_id}/model/{path}"=>{:GET=>[:get_environment_model]},
 "/environments/{env_id}/model/"=>{:PATCH=>[:update_environment_model]},
 "/environments/{env_id}/lastStatus"=>{:GET=>[:get_environment_last_status]},
 "/v1/catalog/packages"=>
  {:GET=>[:list_packages, :search_for_packages], :POST=>[:upload_package]},
 "/v1/catalog/packages/{package_id}/download"=>{:GET=>[:download_package]},
 "/v1/catalog/packages/{package_id}"=>
  {:GET=>[:show_package_details],
   :PATCH=>[:update_package],
   :DELETE=>[:delete_package]},
 "/v1/catalog/packages/{package_id}/ui"=>{:GET=>[:get_ui_definition]},
 "/v1/catalog/packages/{package_id}/logo"=>{:GET=>[:get_logo]},
 "/environments/{env_id}/configure"=>
  {:POST=>[:configure_environment_open_session]},
 "/environments/{env_id}/sessions/{session_id}/deploy"=>
  {:POST=>[:deploy_session]},
 "/environments/{env_id}/sessions/{session_id}"=>
  {:GET=>[:get_session_details], :DELETE=>[:delete_session]},
 "/templates"=>
  {:GET=>[:list_environment_templates], :POST=>[:create_environment_template]},
 "/templates/{env_temp_id}"=>
  {:GET=>[:get_environment_template_details],
   :DELETE=>[:delete_environment_template]},
 "/templates/{env_temp_id}/services"=>
  {:POST=>[:add_application_to_environment_template],
   :GET=>[:list_application_details_for_environment_template]},
 "/templates/{env_temp_id}/services/{service_id}"=>
  {:DELETE=>[:delete_application_from_an_environment_template],
   :PUT=>[:update_application_for_an_environment_template]},
 "/templates/{env_temp_id}/create-environment"=>
  {:GET=>[:create_environment_from_environment_template]},
 "/templates/{env_temp_id}/clone"=>{:GET=>[:clone_environment_template]}}
  end
end
