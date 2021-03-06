view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    #hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

##### Contact Info #####
#To do: Create Full Name

  dimension: first_name {
    type: string
    sql: left(${TABLE}.first_name,1);;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name  {
    type: string
    sql: ${first_name} || ',' || ${last_name} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }



##### Demographic Info #####
#To do: Create years_as_consumer
#To do: Create age tiers

  dimension: age {
    group_label: "Demographic Info"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: number_of_years_as_a_consumer {
    type: number
    sql: ${age}-15 ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [10,20,30,40,50,60,70]
    style: integer
    sql: ${age} ;;
  }

  dimension: gender {
    group_label: "Demographic Info"
    type: string
    sql: ${TABLE}.gender ;;
  }


##### Created Dates Info #####
#To do: Add Quarter Created and Day Of Year Created
  dimension_group: created {
    type: time
    timeframes: [raw,date,month,year,quarter,day_of_year]
    sql: ${TABLE}.created_at ;;
  }

##### Loctaion Info #####
#To do: Add Location for mapping and state map layer for mapping
#To do: Add is_domestic yesNo

  dimension: latitude {
    group_label: "Location Info"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    group_label: "Location Info"
    type: number
    sql: ${TABLE}.longitude ;;
  }

#   dimension: Lat_Long {
#     type: location
#     sql_latitude: ${latitude} ;;
#     sql_longitude: ${longitude} ;;
#   }

  dimension: city {
    group_label: "Location Info"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    group_label: "Location Info"
    type: string
    sql: ${TABLE}.state ;;
#     map_layer_name: us_states
  }

  dimension: country {
    group_label: "Location Info"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: zip {
    group_label: "Location Info"
    type: zipcode
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension: is_domestic {
    type: yesno
    sql: ${country}='USA' ;;

  }

##### Other Info #####
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }


##### Measures #####

# To do: Create Domestic User Count
  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

measure: count_domestic {
  type: count
  filters: {
    field: is_domestic
    value: "yes"
  }
}

#Exercise: Add city, state field
#Exercise: Add age tier with groupings 0-17, 18-64, 65 and above


}
