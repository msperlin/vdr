# script for generating all book files

library(tidyverse)

data_dir <- 'inst/extdata/data/'

# sp500 -- 1950 ----


first_date <- '1950-01-01'
last_date <- '2022-07-01'

df_sp500 <- yfR::yf_get(
  tickers = "^GSPC",
  first_date = first_date,
  last_date = last_date,
  be_quiet = FALSE,
  freq_data = 'daily'
)

df_sp500 <- df_sp500 |>
  select(ref_date, price_adjusted,
         ret_adjusted_prices) |>
  na.omit() |>
  mutate(year = lubridate::floor_date(ref_date,
                                      unit = lubridate::years(10)),
         decade = lubridate::floor_date(ref_date,
                                        unit = lubridate::years(10)))


f_out <- stringr::str_glue(
  'Chapter04-sp500-{lubridate::year(first_date)}-{lubridate::year(last_date)}.csv'
)

write_csv(df_sp500, fs::path(data_dir, f_out ))

##  SELIC
first_date <- '2000-01-01'
last_date <- '2021-12-31'
diff_years <- 3

df_selic <- GetBCBData::gbcbd_get_series(1178, first_date, last_date) |>
  filter(ref.date >= first_date) |>
  mutate(value = value/100) |>
  select(ref.date, value) |>
  rename(ref_date = ref.date,
         selic = value) |>
  mutate(ref_year = lubridate::floor_date(ref_date,
                                      lubridate::years(diff_years))) |>
  filter(ref_year >= first_date)

df_labels <- tibble(
  ref_year = unique(df_selic$ref_year),
  period_label = str_glue("{lubridate::year(ref_year)}-{lubridate::year(ref_year)+ diff_years}")
)

df_selic <- df_selic |>
  left_join(df_labels)

f_out <- stringr::str_glue(
  'Chapter04-selic-{lubridate::year(first_date)}-{lubridate::year(last_date)}.csv'
)

write_csv(df_selic, fs::path(data_dir, f_out ))


##  yield curve BR
library(rb3)

first_date <- '2010-01-01'
last_date <- '2021-12-31'

# df_yc <- yc_mget(first_date, last_date, by = 5)
#
# f_out <- stringr::str_glue(
#   'Chapter04-yield-curve-br-{lubridate::year(first_date)}-{lubridate::year(last_date)}.csv'
# )
#
# write_csv(df_yc, fs::path(data_dir, f_out ))

## credit data - ISLR
credit <- tibble::as_tibble(ISLR::Credit)

numeric_cols <- which(
  sapply(credit , class) %in% c("integer", "numeric")
)

df_num <- credit[, numeric_cols]

f_out <- stringr::str_glue(
  'Chapter04-credit-ISLR.csv'
)

write_csv(df_num, fs::path(data_dir, f_out ))

