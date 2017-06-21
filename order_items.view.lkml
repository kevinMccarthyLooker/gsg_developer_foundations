view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

##### Foreign Keys #####
  dimension: user_id {
    type: number
#   hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    group_label: "Date Created"
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: returned {
    group_label: "Date Returned"
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: status {
    description: "The status of the item"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }
  measure: total_domestic_sale_price {
    type: sum
    sql: ${sale_price} ;;
    filters: {
      field: users.is_domestic
      value: "yes"
    }
    value_format_name: usd
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [id, users.id, inventory_items.id, users.first_name, users.last_name, inventory_items.product_name]
  }

# Exercise: Create 'complete' yesNo field off of status and then total_complete_sale_price
dimension: complete {
  type: yesno
  sql: ${status} =  'Complete';;
}

measure: total_complete_sale_price {
  type: sum
  sql:  ${sale_price} ;;
  filters: {
    field: complete
    value: "yes"
  }
  value_format_name: usd

}
}
