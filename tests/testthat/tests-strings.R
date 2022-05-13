test_that("test of book strings", {

  book_strings <- vdr::book_strings_get()

  expect_true(is.list(book_strings))

})
