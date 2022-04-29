test_that("book files functions", {

  my_dir <- fs::path(tempdir(), 'vdr-test')
  flag <- vdr::vdr_get_book_files(my_dir)

  expect_true(flag)

})
