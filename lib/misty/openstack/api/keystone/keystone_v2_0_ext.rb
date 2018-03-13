module Misty::Openstack::API::KeystoneV2_0_ext
  def tag
    'Identity API Reference v3.10'
  end

  def api_ext
{"/v2.0/ec2tokens"=>{:POST=>[:ec2_authentication]},
 "/v2.0/users/{userId}/credentials/OS-EC2"=>
  {:POST=>[:grant_credential_to_user],
   :GET=>[:list_credentials_ec2_extension]},
 "/v2.0/users/{userId}/credentials/OS-EC2/{credentialId}"=>
  {:DELETE=>[:delete_user_credentials], :GET=>[:get_user_credentials]}}
  end
end
