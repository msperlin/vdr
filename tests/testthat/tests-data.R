test_that("data functions", {

  available_files <- vdr::data_list()

  for (i_file in available_files) {

    path_file <- vdr::data_path(i_file)
    path_ext <- fs::path_ext(path_file)

    df <- vdr::data_import(i_file)

    expect_true(nrow(df) > 0)
    expect_true(tibble::is_tibble(df))
  }

})
