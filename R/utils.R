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

#' Returns local dir of pkg
#'
#' @param sub_dir the sub dir to return path
#'
#' @return a path
#' @export
#'
#' @examples
#' get_pkg_dir("img-exercises")
get_pkg_dir <- function(sub_dir) {
  my_dir <- fs::path(
    system.file("extdata", package = "vdr"),
    sub_dir)

  if (!fs::dir_exists(my_dir)) {
    cli::cli_abort("Cant find dir {my_dir}")
  }

  return(my_dir)
}

#' Returns local dir of pkg
#'
#' @param img_file name of img file
#'
#' @return a path
#' @export
#'
#' @examples
#' exercises_get_img("exercises-latinometrics-instagram_01-SOLUTION-20220927.png")
exercises_get_img <- function(img_file) {
  my_file <- fs::path(
    get_pkg_dir("img-exercises"),
    img_file)

  if (!fs::file_exists(my_file)) {
    cli::cli_abort("Cant find file {my_file}")
  }

  return(my_file)
}

#' Prints imgs in exercises
#'
#' @param img_file name of img file
#' @param this_caption caption of img
#'
#' @return nothing
#' @export
#'
#' @examples
#' exercises_print_img("exercises-latinometrics-instagram_01-SOLUTION-20220927.png", "NONE")
exercises_print_img <- function(img_file, this_caption) {
  my_f <- exercises_get_img(img_file)

  cat(stringr::str_glue(
      "![{this_caption}]({my_f })"
    )
  )
  return(invisible(TRUE))
}
