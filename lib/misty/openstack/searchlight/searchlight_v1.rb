module Misty::Openstack::SearchlightV1
  def v1
{"/v1/search/plugins"=>{:GET=>[:list_plugins]},
 "/v1/search/facets"=>{:GET=>[:list_facets]},
 "/v1/search"=>
  {:POST=>
    [:create_a_general_search,
     :create_a_type_restricted_search,
     :create_an_administrative_search,
     :create_a_free_text_search,
     :create_a_phrase_search,
     :create_a_compound_boolean_search,
     :create_an_aggregated_search]}}
  end
end
