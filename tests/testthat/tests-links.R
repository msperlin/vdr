check_link <- function(link_in) {

  Sys.sleep(1)
  #cli::cli_alert_info("\tChecking {link_in}")

  out_get <- list()
  try({
    out_get <- httr::GET(link_in)
  })

  status_code <- out_get$status_code

  expect_true(status_code == 200)

  return(invisible(TRUE))
}

test_that("test of main book links ", {

  book_links <- vdr::links_get()
  links_to_test <- c(
    book_links$book_github_vdr,
    book_links$blog_site
    # TODO
    #book_links$book_blog_site
    #book_links$book_amazon_ebook,
    #book_links$book_amazon_print
  )

  flags <- purrr::map(links_to_test, check_link)

})
