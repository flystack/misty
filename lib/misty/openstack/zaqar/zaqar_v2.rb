module Misty::Openstack::ZaqarV2
  def api
{"/"=>{:GET=>[:list_major_versions]},
 "/v2/queues"=>{:GET=>[:list_queues]},
 "/v2/queues/{queue_name}"=>
  {:PUT=>[:create_queue],
   :PATCH=>[:update_queue],
   :GET=>[:show_queue_details],
   :DELETE=>[:delete_queue]},
 "/v2/queues/{queue_name}/stats"=>{:GET=>[:get_queue_stats]},
 "/v2/queues/{queue_name}/share"=>{:POST=>[:pre_signed_queue]},
 "/v2/queues/{queue_name}/purge"=>{:POST=>[:purge_queue]},
 "/v2/queues/{queue_name}/messages"=>
  {:POST=>[:post_message], :GET=>[:list_messages]},
 "/v2/queues/{queue_name}/messages?ids={ids}"=>
  {:GET=>[:get_a_set_of_messages_by_id],
   :DELETE=>[:delete_a_set_of_messages_by_id]},
 "/v2/queues/{queue_name}/messages/{messageId}"=>
  {:GET=>[:get_a_specific_message], :DELETE=>[:delete_a_specific_message]},
 "/v2//queues/{queue_name}/claims"=>{:POST=>[:claim_messages]},
 "/v2/queues/{queue_name}/claims/{claim_id}"=>
  {:GET=>[:query_claim],
   :PATCH=>[:update_renew_claim],
   :DELETE=>[:delete_release_claim]},
 "/v2/queues/{queue_name}/subscriptions"=>
  {:GET=>[:list_subscriptions], :POST=>[:create_subscription]},
 "/v2/queues/{queue_name}/subscriptions/{subscription_id}"=>
  {:PATCH=>[:update_subscription],
   :GET=>[:show_subscription_details],
   :DELETE=>[:delete_subscription]},
 "/v2/ping"=>{:GET=>[:ping]},
 "/v2/health"=>{:GET=>[:health]},
 "/v2/pools"=>{:GET=>[:list_pools]},
 "/v2/pools/{pool_name}"=>
  {:PUT=>[:create_pool],
   :PATCH=>[:update_pool],
   :GET=>[:show_pool_details],
   :DELETE=>[:delete_pool]},
 "/v2/flavors"=>{:GET=>[:list_flavors]},
 "/v2/flavors/{flavor_name}"=>
  {:PUT=>[:create_flavor],
   :PATCH=>[:update_flavor],
   :GET=>[:show_flavor_details],
   :DELETE=>[:delete_flavor]}}
  end
end
