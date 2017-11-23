module Misty::Openstack::CeilometerV2
  def api
{"/v2/resources"=>{:GET=>[:list_resources]},
 "/v2/resources/{resource_id}"=>{:GET=>[:show_ressource]},
 "/v2/meters"=>{:GET=>[:list_meters]},
 "/v2/meters/{meter_name}"=>{:GET=>[:show_meter], :POST=>[:create_meter_samples]},
 "/v2/meters/{meter_name}/statistics"=>{:GET=>[:show_statistics]},
 "/v2/samples"=>{:GET=>[:list_samples]},
 "/v2/samples/{sample_id}"=>{:GET=>[:show_sample]},
 "/v2/capabilities"=>{:GET=>[:list_capabilities]},
 "/v2/query/samples"=>{:POST=>[:create_query_sample]}}
  end
end
