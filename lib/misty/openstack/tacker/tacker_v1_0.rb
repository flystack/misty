module Misty::Openstack::TackerV1_0
  def v1_0
{"/"=>{:GET=>[:list_versions]},
 "/v1.0/extensions"=>{:GET=>[:list_extensions]},
 "/v1.0/extensions/{alias}"=>{:GET=>[:show_extension]},
 "/v1.0/vnfds"=>{:POST=>[:create_vnfd], :GET=>[:list_vnfds]},
 "/v1.0/vnfds/{vnfd_id}"=>
  {:GET=>[:show_vnfd], :PUT=>[:update_vnfd], :DELETE=>[:delete_vnfd]},
 "/v1.0/vnfs"=>{:POST=>[:create_vnf], :GET=>[:list_vnfs]},
 "/v1.0/vnfs/{vnf_id}"=>
  {:GET=>[:show_vnf], :PUT=>[:update_vnf], :DELETE=>[:delete_vnf]},
 "/v1.0/vnfs/{vnf_id}/resources"=>{:GET=>[:list_vnf_resources]},
 "/v1.0/vnfs/{vnf_id}/actions"=>{:POST=>[:trigger_vnf_scaling]},
 "/v1.0/vims"=>{:POST=>[:register_vim], :GET=>[:list_vims]},
 "/v1.0/vims/{vim_id}"=>
  {:GET=>[:show_vim], :PUT=>[:update_vim], :DELETE=>[:delete_vim]},
 "/v1.0/events"=>{:GET=>[:list_events]},
 "/v1.0/events/{event_id}"=>{:GET=>[:show_event]},
 "/v1.0/vnffgds"=>{:POST=>[:create_vnffgd], :GET=>[:list_vnffgds]},
 "/v1.0/vnffgds/{vnffgd_id}"=>
  {:GET=>[:show_vnffgd], :DELETE=>[:delete_vnffgd]},
 "/v1.0/vnffgs"=>{:POST=>[:create_vnffg], :GET=>[:list_vnffgs]},
 "/v1.0/vnffgs/{vnffg_id}"=>{:GET=>[:show_vnffg], :DELETE=>[:delete_vnffg]},
 "/v1.0/nfps"=>{:GET=>[:list_nfps]},
 "/v1.0/nfps/{nfp_id}"=>{:GET=>[:show_nfp]},
 "/v1.0/sfcs"=>{:GET=>[:list_sfcs]},
 "/v1.0/sfcs/{sfc_id}"=>{:GET=>[:show_sfc]},
 "/v1.0/classifiers"=>{:GET=>[:list_classifiers]},
 "/v1.0/classifiers/{sfc_id}"=>{:GET=>[:show_classifier]},
 "/v1.0/nsds"=>{:POST=>[:create_nsd], :GET=>[:list_nsds]},
 "/v1.0/nsds/{nsd_id}"=>{:GET=>[:show_nsd], :DELETE=>[:delete_nsd]},
 "/v1.0/nss"=>{:POST=>[:create_ns], :GET=>[:list_nss]},
 "/v1.0/nss/{ns_id}"=>{:GET=>[:show_ns]}}
  end
end
