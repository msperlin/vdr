# script for generating all book files
library(tidyverse)

data_dir <- 'inst/extdata/data/'

##  municipes of brazil
url <- "https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/main/csv/municipios.csv"

df_mun <- readr::read_csv(url)

f_out <- stringr::str_glue(
  'Chapter07-latlong-cities-brazil.csv'
)

write_csv(df_mun, fs::path(data_dir, f_out ))

## data on states
f <- system.file("extdata/rawdata/raw_data_ibge.csv", package = "vdr")

df_ibge <- readr::read_csv(f) |>
  janitor::clean_names()

f_out <- stringr::str_glue(
  'Chapter07-data-ibge.csv'
)

readr::write_csv(df_ibge, fs::path(data_dir, f_out ))
