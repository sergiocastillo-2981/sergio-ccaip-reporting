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
  #measure: count {
  #  type: count
  #  drill_fields: [instance_name, menu_name, agent_name]
  #}
}
