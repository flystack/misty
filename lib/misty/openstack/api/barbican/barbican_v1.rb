module Misty::Openstack::API::BarbicanV1
  def tag
    'Barbican API'
  end

  def api
{"{container_ref}/consumers"=>
  {:GET=>[:list_container_consumers],
   :POST=>[:create_consumer],
   :DELETE=>[:delete_consumer]},
 "/v1/containers"=>{:GET=>[:list_containers], :POST=>[:create_container]},
 "/v1/containers/{uuid}"=>
  {:GET=>[:get_containers], :DELETE=>[:delete_containers]},
 "/v1/containers/{container_uuid}/secrets"=>
  {:POST=>[:create_container_secret], :DELETE=>[:delete_container_secret]},
 "/v1/quotas"=>{:GET=>[:list_quotas]},
 "/v1/project-quotas"=>{:GET=>[:list_project_quotas]},
 "/v1/project-quotas/{uuid}"=>
  {:GET=>[:get_project_quotas],
   :PUT=>[:create_or_update_project_quotas],
   :DELETE=>[:delete_project_quotas]},
 "/v1/secrets/{uuid}/metadata"=>
  {:GET=>[:list_secret_metadata], :PUT=>[:create_secret_metadata]},
 "/v1/secrets/{uuid}/metadata/{key}"=>
  {:GET=>[:get_secret_metadata_key],
   :PUT=>[:update_secret_metadata_key],
   :DELETE=>[:delete_secret_metadata]},
 "/v1/secrets/{uuid}/metadata/"=>{:POST=>[:create_secret_metadata_key]},
 "/v1/secret-stores"=>{:GET=>[:list_secret_stores]},
 "/v1/secret-stores/{secret_store_id}"=>{:GET=>[:get_secret_store]},
 "/v1/secret-stores/preferred"=>{:GET=>[:get_secret_stores_preferred]},
 "/v1/secret-stores/{secret_store_id}/preferred"=>
  {:POST=>[:create_secret_stores_preferred],
   :DELETE=>[:delete_secret_store_preferred]},
 "/v1/secret-stores/global-default"=>
  {:GET=>[:get_secret_stores_global_default]},
 "/v1/secrets"=>{:GET=>[:list_secrets], :POST=>[:update_secrets]},
 "/v1/secrets/{uuid}"=>
  {:GET=>[:get_secret], :PUT=>[:create_secret], :DELETE=>[:delete_secret]},
 "/v1/secrets/{uuid}/payload"=>{:GET=>[:get_secret_payload]}}
  end
end
