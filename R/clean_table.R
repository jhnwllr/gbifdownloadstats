clean_table = function(D) {

  # load(paste0(homeDir,"data/downloadsTable.rda")) # load the full table

  # if(noFilter) D = D %>% filter(!is.na(filter)) # remove those without filter

  D$month = lubridate::month(D$created) # extract month and year
  D$year = lubridate::year(D$created)
  D$monthYear = paste0(D$year,"-",D$month,"-15") # -15 use middle of month to not confuse date converstion

  D$total_records = as.numeric(D$total_records) # change to numeric because of very large int

  # filter out certain downloads
  D = D %>% filter(!grepl("@gbif",notification_addresses)) %>% # remove internal users
    filter(!user == "nagios") %>% # remove nagios whale user
    filter(status == "SUCCEEDED") %>% # only successful downloads
    filter(!is.na(country)) %>% # remove without countries
    filter(!is.na(filter)) # remove those with no filter

  return(D)
}

dateCleanUp = function(D) { # clean up date function used below

  D = D %>% arrange(desc(as.Date(monthYear))) # order by month and year
  D$monthYear = as.Date(D$monthYear) # convert to date to extract month and year
  month = lubridate::month(D$monthYear) # extract month and year
  year = lubridate::year(D$monthYear)
  D$monthYear = paste0(month,"-",year)

  return(D)
}
