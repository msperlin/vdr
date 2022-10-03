test_that("exercise functions", {

  # dir list
  dir_list <- exercises_dir_list()
  expect_true(is.character(dir_list))

  # dir get
  for (i_dir in dir_list) {
    this_dir <- exercises_dir_get(i_dir)

    expect_true(is.character(this_dir))
  }

  # dir get - ERROR
  expect_error({
    exercises_dir_get("error-dir")
  })

  # exercises build
  this_dir <- exercises_dir_get(exercises_dir_list()[1])

  types <- c("html", "latex", "epub3")
  types <- c("html", "latex")
  #types <- c("epub3")
  for (i_type in types) {
    # flag <- exercises_build(this_dir,
    #                        type_doc = i_type)
    #
    # expect_true(flag == TRUE)
  }

  # exercises compilation to html
  temp_path <- fs::file_temp("testthat-vdr-exercises-")
  exercises_compile_solution(dir_output = temp_path)

  n_files <- length(
    fs::dir_ls(temp_path)
  )

  expect_true(n_files == 1)

})
