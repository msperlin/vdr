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
})
