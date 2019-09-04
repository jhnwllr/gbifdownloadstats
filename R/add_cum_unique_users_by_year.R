get_cum_unique_users = function(index,data) {
  data = data %>%
    arrange(desc(year),desc(month)) %>%
    pull(unique_users_list)

  output = 1:index %>%
    map(~
          data[1:.x] %>%
          unlist() %>%
          unique() %>%
          length()
    ) %>%
    flatten_dbl()

}

add_cum_unique_users_by_year = function(d) {
  # d %>%
  # tidyr::unite("year-month",year,month,sep="-",remove=FALSE)

  data_list = d %>%
    arrange(desc(year),desc(month)) %>%
    group_split(year)

  indexes = data_list %>% map(~ .x %>% nrow())

  cumulative_unique_users_by_year = map2(indexes,data_list,~get_cum_unique_users(.x,.y)) %>%
    flatten_dbl() %>%
    rev()

  d = d %>% mutate(cumulative_unique_users_by_year)
  return(d)
}

get_cum_unique_users_country = function(index,data) {

  data_original = data

  data = data %>%
    arrange(desc(year),desc(month)) %>%
    pull(unique_users_list)

  cumulative_unique_users_by_year = 1:index %>%
    map(~
          data[1:.x] %>%
          unlist() %>%
          unique() %>%
          length()
    ) %>%
    flatten_dbl() %>%
    rev()

  data_original = data_original %>%
    mutate(cumulative_unique_users_by_year)

  return(data_original)
}

add_cum_unique_users_by_year_country = function(d) {

  data_list = d %>%
    arrange(desc(year),desc(month)) %>%
    group_split(year,country)

  indexes = data_list %>% map(~ .x %>% nrow())

  cum_unique_users_by_year = map2(indexes,data_list,~get_cum_unique_users_country(.x,.y)) %>%
    bind_rows()

  return(cum_unique_users_by_year)
}





