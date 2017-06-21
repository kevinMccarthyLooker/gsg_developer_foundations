connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"



explore: inventory_items {

  description: "Basic product and inventory information. Please"

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

#To do: Add order_items to this explore
  join: order_items {

    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id}=${users.id} ;;

  }

}



explore: order_items {
  description: "Information about orders including user information"
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
  join: user_lifetime_order_count {
    type: left_outer
    sql_on: ${users.id}=${user_lifetime_order_count.users_id} ;;
    relationship: one_to_one
  }
}
