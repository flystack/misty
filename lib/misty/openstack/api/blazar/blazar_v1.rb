module Misty::Openstack::API::BlazarV1
  def tag
    'Reservation API Reference '
  end

  def api
{"v1/leases"=>{:GET=>[:list_leases], :POST=>[:create_lease]},
 "v1/leases/{lease_id}"=>
  {:GET=>[:show_lease_details],
   :PUT=>[:update_lease],
   :DELETE=>[:delete_lease]},
 "v1/os_hosts"=>{:GET=>[:list_hosts], :POST=>[:create_host]},
 "v1/os_hosts/{host_id}"=>
  {:GET=>[:show_host_details], :PUT=>[:update_host], :DELETE=>[:delete_host]}}
  end
end
