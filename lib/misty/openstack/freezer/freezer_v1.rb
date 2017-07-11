module Misty::Openstack::FreezerV1
  def v1
{"/v1/backups"=>{:GET=>[:lists_backups]},
 "/v1/backups/{backup_id}"=>
  {:GET=>[:show_backups], :DELETE=>[:delete_backups]},
 "/v1/jobs"=>{:GET=>[:lists_jobs], :POST=>[:creates_job]},
 "/v1/jobs/{job_id}"=>
  {:GET=>[:show_jobs], :PATCH=>[:updates_jobs], :DELETE=>[:delete_jobs]},
 "/v1/clients"=>{:GET=>[:lists_clients], :POST=>[:creates_client]},
 "/v1/clients/{client_id}"=>
  {:GET=>[:show_clients], :DELETE=>[:delete_clients]},
 "/v1/actions"=>{:GET=>[:lists_actions], :POST=>[:creates_action]},
 "/v1/actions/{action_id}"=>
  {:GET=>[:show_actions],
   :POST=>[:updates_actions],
   :DELETE=>[:delete_actions]},
 "/v1/sessions"=>
  {:GET=>[:lists_sessions],
   :POST=>[:creates_session],
   :PATCH=>[:updates_a_session]},
 "/v1/sessions/{session_id}"=>
  {:GET=>[:show_sessions], :DELETE=>[:remove_sessions]},
 "/v1/sessions/{session_id}/jobs/{job_id}"=>
  {:PUT=>[:add_jobs], :DELETE=>[:remove_jobs]},
 "/v1/sessions/{session_id}/actions"=>{:POST=>[:start_sessions]}}
  end
end
