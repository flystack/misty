module Misty::Openstack::KeystoneV2_0_ext
  def api_ext
{"/v2.0/users/{user_id}/OS-KSADM/enabled"=>{:PUT=>[:enable_disable_user]},
 "/v2.0/users/{user_id}/OS-KSADM/password"=>{:PUT=>[:set_user_password]},
 "/v2.0/users/{user_id}/OS-KSADM/tenant"=>{:PUT=>[:update_user_tenant]},
 "/v2.0/OS-KSADM/services"=>
  {:POST=>[:create_service_admin_extension],
   :GET=>[:list_services_admin_extension]},
 "/v2.0/OS-KSADM/services/{service_id}"=>
  {:GET=>[:shows_service_information_by_id],
   :DELETE=>[:delete_service_admin_extension]},
 "/v2.0/OS-KSADM/services/{serviceName}"=>
  {:GET=>[:show_service_information_by_name]},
 "/v2.0/OS-KSADM/roles"=>{:POST=>[:create_a_role], :GET=>[:list_all_roles]},
 "/v2.0/OS-KSADM/roles/{role_id}"=>
  {:GET=>[:show_a_role], :DELETE=>[:delete_a_role]},
 "/v2.0/OS-KSADM/roles/{role_name}"=>{:GET=>[:show_role_information_by_name]},
 "/v2.0/tenants/{tenant_id}/users/{user_id}/roles/OS-KSADM/{role_id}"=>
  {:PUT=>[:grant_roles_to_user_on_tenant],
   :DELETE=>[:revoke_role_from_user_on_tenant]},
 "/v2.0/users/{userId}/OS-KSADM/credentials"=>
  {:POST=>[:grant_credential_to_user],
   :GET=>[:list_credentials_ec2_extension]},
 "/v2.0/users/{userId}/OS-KSADM/credentials/OS-KSEC2:ec2Credentials"=>
  {:POST=>[:update_user_credentials],
   :DELETE=>[:delete_user_credentials],
   :GET=>[:get_user_credentials]},
 "/v2.0/users/{userId}/OS-KSADM/credentials/OS-KSEC2:ec2Credentials/{type}"=>
  {:GET=>[:list_credentials_by_type]},
 "/v2.0/OS-KSCRUD/users/{userId}"=>{:PATCH=>[:change_user_s_own_password]}}
  end
end
