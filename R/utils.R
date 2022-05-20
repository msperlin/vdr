#' Formats versions for plots (used in cowplot::plot_grid())
#'
#' @param n_plots number of plots
#'
#' @return a string
#' @export
#'
#' @examples
#' versions_string(10)
versions_string <- function(n_plots) {

  str_out <- sprintf("v%02.f", 1:n_plots)

  return(str_out)
}
