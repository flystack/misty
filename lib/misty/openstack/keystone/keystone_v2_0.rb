module Misty::Openstack::KeystoneV2_0
  def v2_0
{"/v2.0/extensions/{alias}"=>{:GET=>[:show_extension_details]},
 "/v2.0/extensions"=>{:GET=>[:list_extensions]},
 "/v2.0/tenants"=>{:GET=>[:list_tenants]},
 "/v2.0/tokens"=>{:POST=>[:authenticate]},
 "/v2.0"=>{:GET=>[:show_version_details]},
 "/"=>{:GET=>[:list_versions]},
 "/v2.0/tokens/revoked"=>{:GET=>[:list_revoked_tokens_v2]}}
  end
end
