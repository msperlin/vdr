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

  x_formatted <- scales::dollar(x,
                                prefix = 'R$ ',
                                decimal.mark = ',',
                                big.mark = '.',
                                largest_with_cents = Inf)

  return(x_formatted)
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
