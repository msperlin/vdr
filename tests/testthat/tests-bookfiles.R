test_that("book files functions", {

  my_dir <- fs::path(tempdir(), 'vdr-test')
  flag <- vdr::bookfiles_get(my_dir)

  expect_true(flag)

})
