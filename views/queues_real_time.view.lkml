view: queues_real_time {
  sql_table_name: `ccaip-reporting-lab.sergio_ccaip_reporting.t_queues_rt` ;;

  dimension: agents_assigned {
    type: number
    sql: ${TABLE}.AgentsAssigned ;;
  }
  dimension: available {
    type: number
    sql: ${TABLE}.Available ;;
  }
  dimension: avg_queue_duration {
    type: number
    sql: ${TABLE}.AvgQueueDuration ;;
  }
  dimension: channel_type {
    type: string
    sql: ${TABLE}.ChannelType ;;
  }
  dimension: in_queue_count {
    type: number
    sql: ${TABLE}.InQueueCount ;;
  }
  dimension: instance_name {
    type: string
    sql: ${TABLE}.instance_name ;;
  }
  dimension: language {
    type: string
    sql: ${TABLE}.Language ;;
  }
  dimension: logged_on {
    type: number
    sql: ${TABLE}.LoggedOn ;;
  }
  dimension: menu_id {
    type: number
    sql: ${TABLE}.MenuID ;;
  }
  dimension: menu_name {
    type: string
    sql: ${TABLE}.MenuName ;;
  }
  dimension: offline {
    type: number
    sql: ${TABLE}.Offline ;;
  }
  dimension: oldest_duration_in_queue {
    type: number
    sql: ${TABLE}.OldestDurationInQueue ;;
  }
  dimension: oldest_in_queue {
    type: string
    sql: ${TABLE}.OldestInQueue ;;
  }
  dimension: talking_in {
    type: number
    sql: ${TABLE}.TalkingIn ;;
  }
  dimension: total_queue_duration {
    type: number
    sql: ${TABLE}.TotalQueueDuration ;;
  }
  dimension: unavailable {
    type: number
    sql: ${TABLE}.Unavailable ;;
  }
  dimension: wrap_up {
    type: number
    sql: ${TABLE}.Wrap_up ;;
  }
  measure: count {
    type: count
    drill_fields: [instance_name, menu_name]
  }
}
