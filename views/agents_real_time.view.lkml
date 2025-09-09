view: agents_real_time {
  sql_table_name: `ccaip-reporting-lab.sergio_ccaip_reporting.t_agents_rt` ;;

  dimension: agent_id {
    type: number
    sql: ${TABLE}.AgentID ;;
  }
  dimension: agent_name {
    type: string
    sql: ${TABLE}.AgentName ;;
  }
  dimension: call_id {
    type: number
    sql: ${TABLE}.CallID ;;
  }
  dimension: channel_type {
    type: string
    sql: ${TABLE}.ChannelType ;;
  }
  dimension: direction {
    type: string
    sql: ${TABLE}.Direction ;;
  }
  dimension: duration_in_current_state {
    type: number
    sql: ${TABLE}.DurationInCurrentState ;;
  }

  dimension: duration_in_current_state_hms {
    type: number
    sql:  ${duration_in_current_state}/86400.0;;
    value_format: "HH:MM:SS"
  }

  dimension: instance_name {
    type: string
    sql: ${TABLE}.instance_name ;;
  }
  dimension: language {
    type: string
    sql: ${TABLE}.Language ;;
  }
  dimension: last_login_time {
    type: string
    sql: ${TABLE}.LastLoginTime ;;
  }
  dimension: menu_id {
    type: number
    sql: ${TABLE}.MenuID ;;
  }
  dimension: menu_name {
    type: string
    sql: ${TABLE}.MenuName ;;
  }
  dimension: online {
    type: yesno
    sql: ${TABLE}.Online ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }
  dimension: status_updated_at {
    type: string
    sql: ${TABLE}.StatusUpdatedAt ;;
  }

  #-------------------------------CUSTOM-----------------------------------#

  # --- Dimensions (hierarchy) ---
  #dimension: queue_id   { type: string; primary_key: yes; sql: ${TABLE}.queue_id ;; }
  #dimension: agent_id   { type: string; sql: ${TABLE}.agent_id ;; }

  # Level 1: online/offline
  dimension: status_l1
  {
    type: string
    sql:
      CASE
        WHEN ${online} = false THEN 'Offline'
        WHEN ${online} = true THEN 'Online'
        ELSE 'Unknown'
      END ;;
  }

  # Level 2: availability (only relevant when Online)
  dimension: status_l2
  {
    type: string
    sql:
      CASE
        WHEN ${online} = true THEN
          CASE
            WHEN ${status} = 'Available'  THEN 'Available'
            WHEN ${status} in ('Wrap-Up',"In-Call","Wrapup Exceeded","In Chat") THEN 'Busy'
            WHEN ${status} in ('Unavailable','Break',"Meal","Missed Call","Unresponsive") THEN 'Unavailable'--Need to add more statuses here
            WHEN ${status} = 'Offline'    THEN 'Offline'   -- keep exclusive buckets if you pivot this level
            ELSE 'Unknown'
          END
        ELSE NULL
      END;;
  }

  # Level 3:
  dimension: status_l3
  {
    type: string
    sql:
      CASE
        WHEN ${online} = true THEN ${status}

          --CASE
          --  WHEN ${status} in ("In-Call(Other)","Talking In","Talking Out") THEN 'In Call'
          --  ELSE 'Other'
          END
        ELSE NULL
      END ;;
  }


  # --- Base "row" for symmetric aggregates ---
  dimension: row_one
  {
    type: number
    sql: 1 ;;
  }

  # --- Measures (use SUM(CASE...) so they roll up perfectly) ---
  measure: agents_total
  {
    type: number
    sql: SUM(${row_one}) ;;
    drill_fields: [agent_id, status_l1, status_l2, status_l3]
  }

  # Level 1
  measure: agents_offline
  {
    type: number
    sql: SUM(CASE WHEN ${status_l1} = 'Offline' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_online
  {
    type: number
    sql: SUM(CASE WHEN ${status_l1} = 'Online' THEN 1 ELSE 0 END) ;;
  }

  # Level 2 (children of Online)
  measure: agents_available
  {
    type: number
    sql: SUM(CASE WHEN ${status_l2} = 'Available' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_busy
  {
    type: number
    sql: SUM(CASE WHEN ${status_l2} = 'Busy' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_unavailable
  {
    type: number
    sql: SUM(CASE WHEN ${status_l2} = 'Unavailable' THEN 1 ELSE 0 END) ;;
  }

  # Level 3 (children of Unavailable)
  measure: agents_break
  {
    type: number
    sql: SUM(CASE WHEN ${status_l3} = 'Break' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_meal
  {
    type: number
    sql: SUM(CASE WHEN ${status_l3} = 'Meal' THEN 1 ELSE 0 END) ;;
  }

  measure: agents_unresponsive
  {
    type: number
    sql: SUM(CASE WHEN ${status_l3} = 'Unresponsive' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_meeting
  {
    type: number
    sql: SUM(CASE WHEN ${status_l3} = 'Meeting' THEN 1 ELSE 0 END) ;;
  }
  measure: agents_unavailable_other
  {
    type: number
    sql: SUM(CASE WHEN ${status_l3} = 'Other' THEN 1 ELSE 0 END) ;;
  }



  #measure: count {
  #  type: count
  #  drill_fields: [instance_name, menu_name, agent_name]
  #}
}
