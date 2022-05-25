#' Gets official links from book
#'
#' Use this function in the book so that all links are updated in a single location.
#'
#' @return A list with links
#' @export
#'
#' @examples
#'
#' print(links_get())
links_get <- function() {

  my_l <- list(book_site = 'https://www.msperlin.com/blog/publication/XXXX',
               book_site_zip = 'TODO',
               blog_site = 'https://www.msperlin.com/blog')

  return(my_l)

}

#' Copy all book files to local folder
#'
#' This function will grab files from the afedR package and copy all of it to a local folder,
#' separated by directories including R code, data, slides and end-chapter exercises.
#'
#' @param path_to_copy Path to copy all the book files
#'
#' @return TRUE, if sucessful
#' @export
#'
#' @examples
#' bookfiles_get()
bookfiles_get <- function(path_to_copy = '~/vdr-files') {

  if (!dir.exists(path_to_copy)) {

    cli::cli_alert_info('Path {path_to_copy} does not exists and is created.')
    fs::dir_create(path_to_copy, recurse = TRUE)
  }

  # data files
  data_path_files <- system.file('extdata/data', package = 'vdr')
  data_path_to_copy <- file.path(path_to_copy, 'vdr-files/data')

  message('Copying data files files to ', data_path_to_copy)

  if (!dir.exists(data_path_to_copy)) dir.create(data_path_to_copy,
                                                 recursive = TRUE)

  files_to_copy <- list.files(data_path_files, full.names = TRUE)

  flag <- file.copy(from = files_to_copy, to = data_path_to_copy,
                    overwrite = TRUE)

  if (all(flag)) message(paste0('\t', length(flag), ' files copied'))

  # Slides
  slides_path_files <- system.file('extdata/slides', package = 'vdr')
  slides_path_to_copy <- file.path(path_to_copy, 'vdr-files/slides')

  message('Copying slides files files to ', slides_path_to_copy)
  if (!dir.exists(slides_path_to_copy)) dir.create(slides_path_to_copy,
                                                   recursive = TRUE)

  files_to_copy <- list.files(slides_path_files, full.names = TRUE,
                              include.dirs = TRUE)

  flag <- file.copy(from = files_to_copy, to = slides_path_to_copy,
                    overwrite = TRUE, recursive = TRUE)

  if (all(flag)) message(paste0('\t', length(flag), ' files copied'))

  # EOC exercises
  eoc_exerc_path_files <- system.file('extdata/eoc-exercises', package = 'vdr')
  eoc_exerc_path_to_copy <- file.path(path_to_copy, 'vdr-files/eoc-exercises')

  message('Copying end-of-chapter (eoc) exercises with solutions to ',
          eoc_exerc_path_to_copy)
  if (!dir.exists(eoc_exerc_path_to_copy)) dir.create(eoc_exerc_path_to_copy,
                                                      recursive = TRUE)

  files_to_copy <- list.files(eoc_exerc_path_files, full.names = TRUE)

  flag <- file.copy(from = files_to_copy,
                    to = eoc_exerc_path_to_copy,
                    overwrite = TRUE)

  if (all(flag)) message(paste0('\t', length(flag), ' files copied'))

  # R code
  r_code_path_files <- system.file('extdata/R-code', package = 'vdr')
  r_code_exerc_path_to_copy <- file.path(path_to_copy, 'vdr-files/R-code')

  message('Copying end-of-chapter (eoc) exercises with solutions to ',
          r_code_exerc_path_to_copy)
  if (!dir.exists(r_code_exerc_path_to_copy)) dir.create(r_code_exerc_path_to_copy,
                                                         recursive = TRUE)

  files_to_copy <- list.files(r_code_path_files, full.names = TRUE)

  flag <- file.copy(from = files_to_copy,
                    to = r_code_exerc_path_to_copy,
                    overwrite = TRUE)

  if (all(flag)) message(paste0('\t', length(flag), ' files copied'))

  return(invisible(TRUE))
}

#' Retrieves book strings
#'
#' @return a list
#' @export
#'
#' @examples
#' book_strings_get()
book_strings_get <- function() {

  l_out <- list(
    book_title = "Visualiza\\u00e7\\u00e3o de Dados com o R",
    book_subtitle = "Aplica\\u00e7\\u00f5es em Finan\\u00e7as e Economia",
    publication_years = c(2022),
    publication_names = c("Edi\\u00e7 01"),
    author_name = "Marcelo S. Perlin",
    author_email = "marceloperlin@gmail.com"
  )

  return(l_out)
}


#' Use color in book text
#'
#' From: https://bookdown.org/yihui/rmarkdown-cookbook/font-color.html
#'
#' @param x A text to be colorized
#' @param color the color (e.g. "red")
#'
#' @return a colorized version of string (html or latex)
#' @export
#'
#' @examples
#' colorize("ABC", "red")
colorize <- function(x, color) {

  if (knitr::is_latex_output()) {

    sprintf("\\textcolor{%s}{%s}", color, x)

  } else if (knitr::is_html_output()) {

    sprintf("<span style='color: %s;'>%s</span>", color,
            x)

  } else {
    x
  }
}
