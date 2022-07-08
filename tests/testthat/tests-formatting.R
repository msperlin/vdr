test_that("format functions", {

  # format_percent
  this_perc <- vdr::format_percent(
    runif(1)
  )

  expect_true(is.character(this_perc))
  expect_true(stringr::str_detect(this_perc, '%'))

  # format_cash
  this_cash <- vdr::format_cash(rnorm(1))

  expect_true(is.character(this_cash))
  expect_true(stringr::str_detect(this_cash,
                                  stringr::fixed('R$')))

  # format_date
  this_date <- vdr::format_date(Sys.Date())
  expect_true(is.character(this_date))

  # format_number
  this_number <- vdr::format_number(runif(1))
  expect_true(is.character(this_number))

  # format citation
  this_cit <- format_pkg_citation("dplyr")
  expect_true(is.character(this_cit))

  # format vect-to-string
  str_out <- format_vec_as_text(c("A", "B", "C"))
  expect_true(is.character(str_out))
})
