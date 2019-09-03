
db_con = function(pw) {

con = dbConnect(RPostgres::Postgres()
                ,host='pg1.gbif.org'
                ,port='5432'
                ,dbname='prod_b_registry'
                ,user='jwaller'
                ,password=pw)

return(con)
}

download_occurrence_download = function(con) {
  qs = 'SELECT * FROM occurrence_download;'
  occurrence_download = dbGetQuery(con,qs)
  return(occurrence_download)
}

download_user = function(con) {
  qs = "SELECT email, username as user, settings -> 'country' as country FROM public.user;"
  user = dbGetQuery(con,qs)
  return(user)
}

download_and_clean_table = function(pw) {

  con = db_con(pw) # connection to database

  clean_table = download_occurrence_download(con) %>%
    mutate(user = created_by) %>%
    merge(download_user(con),id="user",all.x=TRUE) %>% # merge the tables
    clean_table()

  return(clean_table)
}


