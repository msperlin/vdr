# Repository for R package vdr

<!-- badges: start -->
[![R-CMD-check](https://github.com/msperlin/vdr/workflows/R-CMD-check/badge.svg)](https://github.com/msperlin/vdr/actions)
<!-- badges: end -->

Includes several functions related to book "Visualização de Dados com o R", to be published, hopefully, in mid 2021. 

## Installation

```
# only in github (will not pass cran checks)
devtools::install_github('msperlin/vdr')
```

## Example of usage

### Listing available datasets

```
afedR::vdr_list_available_data()
```

### Fetching data from book repository

```
file_name <- 'SP500.csv'
path_to_file <- vdr::vdr_get_data_file(file_name)

df <- readr::read_csv(path_to_file)
```

### Copying all book files to local directory

```
flag <- vdr::vdr_get_book_files(path_to_copy = '~')
```


