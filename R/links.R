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

  my_l <- list(book_blog_vdr  = 'https://www.msperlin.com/blog/publication/2022_book-vdr/',
               book_amazon_ebook = "https://www.msperlin.com/vdr", #TODO
               book_amazon_print = "https://www.msperlin.com/vdr", #TODO
               book_amazon_hardcover = "https://www.msperlin.com/vdr", #TODO
               book_github_vdr = 'https://github.com/msperlin/vdr',
               book_online = "https://www.msperlin.com/vdr",
               blog_site = 'https://www.msperlin.com/blog',
               adfer_web = "https://www.msperlin.com/adfeR",
               exercises_solutions = "https://www.msperlin.com/vdr/vdr-eoc-solutions.html")

  return(my_l)

}
