test_that("data functions", {

  available_files <- vdr::vdr_list_available_data()

  for (i_file in available_files) {

    path_file <- vdr_get_data_file(i_file)
    path_ext <- fs::path_ext(path_file)

    if (path_ext == 'xlsx') {
      df <- readxl::read_excel(path_file)
    } else if (path_ext == 'csv') {
      df <- readr::read_csv(path_file,
                            )
    }

    expect_true(nrow(df) > 0)
  }

})
