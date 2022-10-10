.onAttach <- function(libname,pkgname) {

  my_links <- links_get()
  do_color <- crayon::make_style("#FF4141")
  this_pkg <- 'vdr'

  data_files <- list.files(
    get_pkg_dir("data")
  )

  script_files <- list.files(
    get_pkg_dir("book-scripts")
  )

  exercise_files <- list.files(
    get_pkg_dir("eoce"), recursive = TRUE
  )

  if (interactive()) {
    msg <- paste0('\nPackage vdr sucessfully loaded!',
                  ' Here youll find:\n',
                  '\t', length(data_files), ' data files \n',
                  '\t', length(script_files), ' book scripts for building data files \n',
                  '\t', length(exercise_files), ' end of chapter exercises',
                  '\n\n',
                  "Useful links:\n",
                  "\tAuthor site: ", cli::style_hyperlink(my_links$blog_site,
                                                       my_links$blog_site),
                  "\n\tBook online: ", cli::style_hyperlink(my_links$book_online, my_links$book_online ),
                  "\n\tAmazon site: ", cli::style_hyperlink(my_links$book_amazon_ebook,
                                                          my_links$book_amazon_ebook))
  } else {
    msg <- ''
  }

  packageStartupMessage(msg)

}
