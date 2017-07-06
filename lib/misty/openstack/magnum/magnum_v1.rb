module Misty::Openstack::MagnumV1
  def v1
{"/"=>{:GET=>[:list_api_versions]},
 "/v1/"=>{:GET=>[:show_v1_api_version]},
 "/v1/bays"=>{:POST=>[:create_new_bay]},
 "/v1/bays/"=>{:GET=>[:list_all_bays]},
 "/v1/bays/{bay_ident}"=>
  {:GET=>[:show_details_of_a_bay],
   :DELETE=>[:delete_a_bay],
   :PATCH=>[:update_information_of_bay]},
 "/v1/baymodels/"=>
  {:POST=>[:create_new_baymodel], :GET=>[:list_all_baymodels]},
 "/v1/baymodels/{baymodel_ident}"=>
  {:GET=>[:show_details_of_a_baymodel],
   :DELETE=>[:delete_a_baymodel],
   :PATCH=>[:update_information_of_baymodel]},
 "/v1/clusters"=>{:POST=>[:create_new_cluster], :GET=>[:list_all_clusters]},
 "/v1/clusters/{cluster_ident}"=>
  {:GET=>[:show_details_of_a_cluster],
   :DELETE=>[:delete_a_cluster],
   :PATCH=>[:update_information_of_cluster]},
 "/v1/clustertemplates"=>
  {:POST=>[:create_new_cluster_template], :GET=>[:list_all_cluster_templates]},
 "/v1/clustertemplates/{clustertemplate_ident}"=>
  {:GET=>[:show_details_of_a_cluster_template],
   :DELETE=>[:delete_a_cluster_template],
   :PATCH=>[:update_information_of_cluster_template]},
 "/v1/certificates/{bay_uuid/cluster_uuid}"=>
  {:GET=>[:show_details_about_the_ca_certificate_for_a_bay_cluster],
   :PATCH=>[:rotate_the_ca_certificate_for_a_bay_cluster]},
 "/v1/certificates/"=>
  {:POST=>[:generate_the_ca_certificate_for_a_bay_cluster]},
 "/v1/mservices"=>{:GET=>[:list_container_infrastructure_management_services]},
 "/v1/stats?project_id="=>{:GET=>[:show_stats_for_a_tenant]},
 "/v1/stats"=>{:GET=>[:show_overall_stats]},
 "/v1/quotas"=>{:POST=>[:set_new_quota], :GET=>[:list_all_quotas]},
 "/v1/quotas/{project_id}/{resource}"=>
  {:GET=>[:show_details_of_a_quota],
   :PATCH=>[:update_a_resource_quota],
   :DELETE=>[:delete_a_resource_quota]}}
  end
end
