.onAttach <- function(libname,pkgname) {

  my_links <- links_get()
  do_color <- crayon::make_style("#FF4141")
  this_pkg <- 'vdr'

  data_files <- list.files(
    system.file('extdata/data', package = 'vdr')
  )
  script_files <- list.files(
    system.file('extdata/book-scripts', package = 'vdr')
  )

  if (interactive()) {
    msg <- paste0('\nPackage vdr sucessfully loaded! ',
                  'Here youll find:\n\n',
                  '\t', length(data_files), ' data files \n',
                  '\t', length(script_files), ' book scripts for building data files \n',
                  '\n',
                  "Useful links:\n",
                  "Author site: ", cli::style_hyperlink(my_links$blog_site,
                                                       my_links$blog_site),
                  "\nBook site: ", cli::style_hyperlink(my_links$book_blog_site,my_links$book_blog_site ),
                  "\nAmazon site: ", cli::style_hyperlink(my_links$book_amazon_ebook,
                                                          my_links$book_amazon_ebook))
  } else {
    msg <- ''
  }

  packageStartupMessage(msg)

}
