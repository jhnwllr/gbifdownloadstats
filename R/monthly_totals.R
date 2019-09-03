monthly_totals = function(D) {

  monthly_totals = D %>%
    group_by(month,year) %>%
    summarise(Records=sum(total_records,na.rm=TRUE),Downloads=n(),Users=n_distinct(user),unique_users_list=list(unique(user))) %>%
    ungroup() %>%
    arrange(desc(year),month) %>%
    group_by(year) %>%
    mutate(cumulative_downloads_by_year = cumsum(Downloads)) %>%
    mutate(cumulative_records_downloaded_by_year = cumsum(Records)) %>%
    ungroup() %>%
    arrange(desc(year),desc(month)) %>%
    add_cum_unique_users_by_year() # complicated cumulative distinct user counts


  return(monthly_totals)
}

monthly_totals_country = function(D) {

  monthly_totals_country = D %>%
    group_by(month,year,country) %>%
    summarise(Records=sum(total_records,na.rm=TRUE),Downloads=n(),Users=n_distinct(user),unique_users_list=list(unique(user))) %>%
    ungroup() %>%
    arrange(desc(year),month) %>%
    group_by(year,country) %>%
    mutate(cumulative_downloads_by_year = cumsum(Downloads)) %>%
    mutate(cumulative_records_downloaded_by_year = cumsum(Records)) %>%
    ungroup() %>%
    add_cum_unique_users_by_year_country() %>%
    arrange(desc(year),desc(month),country) %>%
    select(-unique_users_list)

return(monthly_totals_country)
}

