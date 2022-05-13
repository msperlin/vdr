
# Repository for R package vdr

<!-- badges: start -->

[![R-CMD-check](https://github.com/msperlin/vdr/workflows/R-CMD-check/badge.svg)](https://github.com/msperlin/vdr/actions)
<!-- badges: end -->

Includes several functions related to book “Visualização de Dados com o
R”, to be published, hopefully, in mid 2021.

## Installation

``` r
# install from github (up to date version)
if (!require(devtools)) install.packages(devtools)
devtools::install_github('msperlin/vdr')
```

## Example of usage

### Listing available datasets

``` r
vdr::data_list()
```

    ## 

    ## ── Available data files (name|path) ────────────────────────────────────────────

    ## ℹ Chapter02-inflation-BR-2006-2010.csv   | /tmp/Rtmpq5h0oP/temp_libpath7c7b3cd6c543/vdr/extdata/data/Chapter02-inflation-BR-2006-2010.csv

    ## ℹ Chapter02-inflation-BR-2018-2022.csv   | /tmp/Rtmpq5h0oP/temp_libpath7c7b3cd6c543/vdr/extdata/data/Chapter02-inflation-BR-2018-2022.csv

    ## ℹ Chapter02-PETR3-and-BVSP-2015-2022.csv | /tmp/Rtmpq5h0oP/temp_libpath7c7b3cd6c543/vdr/extdata/data/Chapter02-PETR3-and-BVSP-2015-2022.csv

    ## ℹ Chapter02-Petrobras-monthly-stock-prices-2015-2022.csv | /tmp/Rtmpq5h0oP/temp_libpath7c7b3cd6c543/vdr/extdata/data/Chapter02-Petrobras-monthly-stock-prices-2015-2022.csv

    ## 

    ## ✔ You can read files using vdr::data_import(name_of_file)

    ## ✔ Example: df <- vdr::data_import('Chapter02-inflation-BR-2018-2022.csv')

### Fetching data from book repository

``` r
df <- vdr::data_import('Chapter02-PETR3-and-BVSP-2015-2022.csv')

dplyr::glimpse(df)
```

    ## Rows: 176
    ## Columns: 11
    ## $ ticker                 <chr> "^BVSP", "^BVSP", "^BVSP", "^BVSP", "^BVSP", "^…
    ## $ ref_date               <date> 2015-01-02, 2015-02-02, 2015-03-02, 2015-04-01…
    ## $ volume                 <dbl> 77719800, 65310100, 79890000, 81114600, 6784570…
    ## $ price_open             <dbl> 47759, 51760, 51243, 55312, 53974, 53014, 49897…
    ## $ price_high             <dbl> 50281, 52457, 52319, 56965, 58575, 54361, 53456…
    ## $ price_low              <dbl> 46484, 46760, 47905, 51186, 52760, 52548, 48624…
    ## $ price_close            <dbl> 46908, 51583, 51150, 56229, 52760, 53081, 50865…
    ## $ price_adjusted         <dbl> 46908, 51583, 51150, 56229, 52760, 53081, 50865…
    ## $ ret_adjusted_prices    <dbl> NA, 0.099663170, -0.008394238, 0.099296188, -0.…
    ## $ ret_closing_prices     <dbl> NA, 0.099663170, -0.008394238, 0.099296188, -0.…
    ## $ cumret_adjusted_prices <dbl> 1.0000000, 1.0996632, 1.0904323, 1.1987081, 1.1…

### Copying all book files to local directory

``` r
flag <- vdr::bookfiles_get()
```

    ## Copying data files files to /home/msperlin/vdr-files/vdr-files/data

    ##  4 files copied

    ## Copying slides files files to /home/msperlin/vdr-files/vdr-files/slides

    ##  0 files copied

    ## Copying end-of-chapter (eoc) exercises with solutions to /home/msperlin/vdr-files/vdr-files/eoc-exercises

    ##  0 files copied

    ## Copying end-of-chapter (eoc) exercises with solutions to /home/msperlin/vdr-files/vdr-files/R-code

    ##  0 files copied
