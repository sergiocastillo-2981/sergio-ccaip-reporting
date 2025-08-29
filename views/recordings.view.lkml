 view: recordings {

   derived_table: {
     sql: SELECT
         id,link
       FROM @{PROJECT_NAME}.@{DATASET}.`v_recordings` v

       ;;
   }

  dimension: id
  {
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: recording_link
  {
    sql: ${TABLE}.link ;;
  }

  dimension: recording_audio
  {
    #Recording Stored on the GCP Bucket, the recording must be on the same connection as the looker connection
    sql:  ${TABLE}.link;;
    #Link to the Recording
    #html: <a href="{{value}}" target="_blank"><img src="https://icon-library.com/images/icon-sound/icon-sound-1.jpg" alt="Recording Link" style="width:32px;height:32px";></a> ;;

    #Embeded Recording
    html:
        <audio controls controlsList="nodownload">
        <source src="{{value}}"  type="audio/mpeg">
        </audio>
      ;;
  }

  dimension: recording_test
  {
    sql: ${TABLE}.link ;;
    html:
      <iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url={{value}};">
      </iframe>
      ;;

  }

#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
