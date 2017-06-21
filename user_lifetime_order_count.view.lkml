view: user_lifetime_order_count {
  derived_table: {
    sql: SELECT
        users.id  AS "users.id",
        COUNT(*) AS "order_items.count"
      FROM public.order_items  AS order_items
      LEFT JOIN public.users  AS users ON order_items.user_id = users.id

      GROUP BY 1
       ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}."users.id" ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}."order_items.count" ;;
  }

}
