module Misty::Openstack::API::KeystoneV2_0_ext
  def tag
    'Identity API Reference v3.8'
  end

  def api_ext
{"/v2.0/users/{userId}/OS-KSADM/credentials"=>
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
