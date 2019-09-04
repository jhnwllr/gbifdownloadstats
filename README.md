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
library(RPostgres) # needed for database connection 
library(DBI) # needed for database connection 
library(dplyr) 
library(roperators) # for %+% string operator
library(purrr)
library(readr)

pw = {""} # you will need a password with admin access
Dir = "C:/Users/ftw712/Desktop/"

download_and_clean_table(pw,user='jwaller') %>% saveRDS(Dir %+% "clean_table.rda") 

D = readRDS(Dir %+% "clean_table.rda")

D %>% monthly_totals_country() %>% readr::write_tsv(Dir %+% "monthly_totals_country.tsv")
D %>% monthly_totals() %>% readr::write_tsv(Dir %+% "monthly_totals.tsv")

```

These downloads are filtered out by default in `clean_table.R`

```
filter(!grepl("@gbif",notification_addresses)) # remove those with gbif emails
filter(!user == "nagios") %>% # remove nagios whale user
filter(status == "SUCCEEDED") %>% # only successful downloads
filter(!is.na(country)) %>% # remove without country
filter(!is.na(filter)) # remove those with no filter
```

* **cumulative_downloads_by_year** number of downloads for that country that year up to that month and year. 
* **cumulative_records_downloaded_by_year** number of occurrences downloaded for that country up to that month and year. 
* **cumulative_unique_users_by_year** number of unique users for that country up to that month and year.
* **Records** is the number of occurrences records downloaded for that country, month, and year
* **Downloads** is the number of successful downloads  for that country, month, and year
* **Users** is the number of unique users for that country, month, and year

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


**monthly_totals.tsv** will end up looking like this:

|month|year|Records|Downloads |Users|cumulative_downloads_by_year|cumulative_records_downloaded_by_year|cumulative_unique_users_by_year|
|-----|----|-------|----------|-----|----------------------------|-------------------------------------|------------------------|
|9    |2019|8285028793|1041      |413  |93754                       |313306197135                         |14354                   |
|8    |2019|33339285771|10240     |2358 |92713                       |305021168342                         |13207                   |
|7    |2019|24984137297|12228     |2266 |82473                       |271681882571                         |11702                   |
|6    |2019|48831591827|12081     |2308 |70245                       |246697745274                         |9828                    |
|5    |2019|40999004794|11637     |2664 |58164                       |197866153447                         |8003                    |
|4    |2019|46819232448|12413     |2767 |46527                       |156867148653                         |6147                    |
|3    |2019|42671385689|13194     |2864 |34114                       |110047916205                         |4466                    |
|2    |2019|33937946304|11391     |2618 |20920                       |67376530516                          |2659                    |
|1    |2019|33438584212|9529      |2090 |9529                        |33438584212                          |413                     |
|12   |2018|32511129326|7887      |1762 |150907                      |405733289179                         |16544                   |
|11   |2018|30799402536|13131     |2511 |143020                      |373222159853                         |15644                   |
|10   |2018|29013725646|14449     |2749 |129889                      |342422757317                         |14531                   |
|9    |2018|23934550928|13434     |2160 |115440                      |313409031671                         |13218                   |





