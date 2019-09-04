# gbifdownloadstats


installation in R:

```
devtools::install_github("jhnwllr/gbifdownloadstats")
```

Generate stats **cumulative monthly stats** similar to what is produced:

* https://github.com/jlegind/GBIF_monthly_statistics
* https://jlegind.github.io/


```
library(gbifdownloadstats) # my package
library(RPostgres) # need for database connection 
library(DBI)
library(dplyr) 
library(roperators)
library(purrr)
library(readr)
library(magrittr)

pw = {""} # you will need a password with admin access
Dir = "C:/Users/ftw712/Desktop/"

download_and_clean_table(pw,user='jwaller') %>% saveRDS(Dir %+% "clean_table.rda") 

D = readRDS(Dir %+% "clean_table.rda")

D %>% monthly_totals_country() %>% readr::write_tsv(Dir %+% "monthly_totals_country.tsv")
D %>% monthly_totals() %>% readr::write_tsv(Dir %+% "monthly_totals.tsv")

```

**monthly_totals_country.tsv** will end up looking like this:

|month|year|country|Records   |Downloads|Users|cumulative_downloads_by_year|cumulative_records_downloaded_by_year|cumulative_unique_users_by_year|
|-----|----|-------|----------|---------|-----|----------------------------|-------------------------------------|-------------------------------|
|9    |2019|AR     |188463    |8        |7    |1750                        |3309216653                           |248                            |
|9    |2019|AT     |61179     |2        |2    |199                         |883351221                            |69                             |
|9    |2019|AU     |879359767 |27       |9    |1286                        |6795241991                           |242                            |
|9    |2019|BE     |358       |2        |2    |1959                        |1401978115                           |113                            |
|9    |2019|BJ     |23268     |13       |2    |751                         |12238068498                          |97                             |
|9    |2019|BR     |3785935   |87       |38   |7055                        |12667462146                          |1045                           |
|9    |2019|CA     |193490256 |3        |3    |2050                        |8042661847                           |315                            |
|9    |2019|CH     |1038203   |5        |4    |215                         |141166933                            |65                             |
|9    |2019|CI     |305       |6        |1    |217                         |8550772                              |16                             |
|9    |2019|CL     |1245483151|57       |29   |3131                        |6812675060                           |272                            |
|9    |2019|CM     |1229      |1        |1    |275                         |2700031                              |12                             |
|9    |2019|CN     |1369887036|61       |27   |5628                        |29605704526                          |641                            |
|9    |2019|CO     |179976230 |63       |26   |5717                        |12690300069                          |1055                           |
|9    |2019|CR     |99        |2        |1    |474                         |2944031804                           |91                             |
|9    |2019|CZ     |140707    |4        |3    |303                         |105322168                            |38                             |
|9    |2019|DE     |103360    |11       |5    |1685                        |17653637583                          |308                            |
|9    |2019|EC     |84        |1        |1    |1919                        |936720930                            |303                            |







