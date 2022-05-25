#' Format cash
#'
#' @param x a number
#'
#' @return formatted string
#' @export
#'
#' @examples
#' format_cash(10)
format_cash <- function(x) {

  x_fmt <- scales::dollar(x,
                          prefix = 'R$ ',
                          decimal.mark = ',',
                          big.mark = '.',
                          largest_with_cents = Inf)

  return(x_fmt)
}


#' Formats percentage
#'
#' @param x a number
#'
#' @return formatted string
#' @export
#'
#' @examples
#' format_percent(0.55)
format_percent <- function(x) {

  x_fmt <- scales::percent(x,
                           accuracy = 0.01,
                           decimal.mark = ',',
                           big.mark = '.')

  return(x_fmt)
}

#' Formats date to BR standard (DD/MM/YYYY)
#'
#' @param x a date in ISO format (YYY-MM-DD)
#'
#' @return formatted date
#' @export
#'
#' @examples
#' format_date("2010-01-01")
format_date <- function(x) {

  x <- as.Date(x)
  x_fmt <- format(x, '%d/%m/%Y')

  return(x_fmt)
}

#' Produces package citation string
#'
#' Formats package as `pkg` and, when called the first time, adds reference as
#' [@R-pkg]
#'
#' @param pkg a pkg availabe locally or github
#' @param force_ref Logical (TRUE or FALSE) - defines whether to force formal
#' reference (e.g. [@R-pkg])
#' @return a string in rmarkdown
#' @export
#'
#' @examples
#' format_pkg_citation("dplyr")
format_pkg_citation <- function(pkg, force_ref = FALSE) {

  folder_db_citation <- fs::path_temp("bookdown-pkg-citations")

  if (!fs::dir_exists(folder_db_citation)) fs::dir_create(folder_db_citation)
  available_cit <- basename(fs::dir_ls(folder_db_citation))

  str_index <- paste0("\\index{", pkg, "}")
  if ((pkg %in% available_cit) & (!force_ref)) {

    pkg_citation <- stringr::str_glue("`{pkg} {str_index}`")

  } else {

    this_cit_file <- fs::path(folder_db_citation, pkg)
    fs::file_touch(this_cit_file)

    pkg_citation <- stringr::str_glue("`{pkg}`  {str_index} [@R-{pkg}]")
  }

  return(pkg_citation)

}
