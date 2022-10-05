#' Get official links from book
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

  my_l <- list(book_blog_site = 'https://www.msperlin.com/blog/publication/XXXX',
               book_blog_vdr  = 'https://www.msperlin.com/vdr',
               book_amazon_ebook = "TBD",
               book_amazon_print = "TBD",
               book_amazon_hardcover = "TBD",
               book_github_vdr = 'https://github.com/msperlin/vdr',
               book_github_source = 'TBD',
               blog_site = 'https://www.msperlin.com/blog',
               adfer_web = "https://www.msperlin.com/adfeR",
               exercises_solutions = "https://www.msperlin.com/vdr")

  return(my_l)

}
