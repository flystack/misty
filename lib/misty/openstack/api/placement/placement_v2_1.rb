module Misty::Openstack::API::PlacementV2_1
  def tag
    'Placement API Reference 17.0.0'
  end

  def api
{"/"=>{:GET=>[:list_versions]},
 "/resource_providers"=>
  {:GET=>[:list_resource_providers], :POST=>[:create_resource_provider]},
 "/resource_providers/{uuid}"=>
  {:GET=>[:show_resource_provider],
   :PUT=>[:update_resource_provider],
   :DELETE=>[:delete_resource_provider]},
 "/resource_classes"=>
  {:GET=>[:list_resource_classes], :POST=>[:create_resource_class]},
 "/resource_classes/{name}"=>
  {:GET=>[:show_resource_class],
   :PUT=>
    [:update_resource_class, :update_resource_class_microversions_1_2_1_6],
   :DELETE=>[:delete_resource_class]},
 "/resource_providers/{uuid}/inventories"=>
  {:GET=>[:list_resource_provider_inventories],
   :PUT=>[:update_resource_provider_inventories],
   :DELETE=>[:delete_resource_provider_inventories]},
 "/resource_providers/{uuid}/inventories/{resource_class}"=>
  {:GET=>[:show_resource_provider_inventory],
   :PUT=>[:update_resource_provider_inventory],
   :DELETE=>[:delete_resource_provider_inventory]},
 "/resource_providers/{uuid}/aggregates"=>
  {:GET=>[:list_resource_provider_aggregates],
   :PUT=>[:update_resource_provider_aggregates]},
 "/traits"=>{:GET=>[:list_traits]},
 "/traits/{name}"=>
  {:GET=>[:show_traits], :PUT=>[:update_traits], :DELETE=>[:delete_traits]},
 "/resource_providers/{uuid}/traits"=>
  {:GET=>[:list_resource_provider_traits],
   :PUT=>[:update_resource_provider_traits],
   :DELETE=>[:delete_resource_provider_traits]},
 "/allocations"=>{:POST=>[:manage_allocations]},
 "/allocations/{consumer_uuid}"=>
  {:GET=>[:list_allocations],
   :PUT=>[:update_allocations],
   :DELETE=>[:delete_allocations]},
 "/resource_providers/{uuid}/allocations"=>
  {:GET=>[:list_resource_provider_allocations]},
 "/usages"=>{:GET=>[:list_usages]},
 "/resource_providers/{uuid}/usages"=>{:GET=>[:list_resource_provider_usages]},
 "/allocation_candidates"=>{:GET=>[:list_allocation_candidates]}}
  end
end
