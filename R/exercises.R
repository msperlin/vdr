#' Builds eoc exercises
#'
#' @param folder_in folder with exercise files to render
#' @param type_doc type of document (from knitr::pandoc_to())
#'
#' @return nothing
#' @export
#'
#' @examples
#' exercises_build(exercises_dir_get(exercises_dir_list()[1]),
#'  type_doc = "html")
exercises_build <- function(folder_in, type_doc) {

  link_eoc_exercises <- links_get()$book_blog_vdr

  text_exercises <- stringr::str_glue(
    'Todas soluções de exercícios estão disponíveis no ',
    '[site do livro]({link_eoc_exercises}).'
  )


  files_in <- fs::dir_ls(folder_in)

  my_counter <- 1

  if (is.null(type_doc)) {
    type_doc = 'html'
    #type_doc = 'latex'
  }

  if (type_doc %in% c('latex', 'epub3')) {
    cat(text_exercises, '\n')
  }

  supp_path <- c()
  for (i_ex in files_in) {
    l_out <- exercise_to_text(i_ex,
                              my_counter = my_counter,
                              type_doc)

    supp_path <- c(
      supp_path,
      l_out$supplements
    )

    my_counter <- my_counter + 1
  }

  return(invisible(TRUE))
}

#' exercises -> html
#'
#' @noRd
exercise_to_text <- function(f_in, my_counter, type_doc) {

  # for naming exercises
  basename_f_in <- basename(f_in)

  text_pre_solution <- paste0('Para chegar no resultado anterior, deves executar o código abaixo. ',
                              'Para isso, abra um novo script no RStudio (Control+shift+N), ',
                              ' copie e cole o código, e rode o ',
                              'script inteiro apertando Control+Shift+Enter ou por linha com ',
                              'Control+Enter.')

  my_dir <- file.path(tempdir(),
                      basename(tempfile(pattern = type_doc)))
  dir.create(my_dir)

  #browser()
  # supp_folder <- "~/Desktop/supp"
  # fs::dir_create(supp_folder)

  suppressMessages({
    l_out <- exams::xexams(f_in,
                           driver = list(sweave = list(png = TRUE)),
                           dir = my_dir)

  })

  exercise_text <- paste0(l_out$exam1$exercise1$question, collapse = '\n')
  alternatives <- l_out$exam1$exercise1$questionlist
  correct <- l_out$exam1$exercise1$metainfo$solution
  solution <- paste0(l_out$exam1$exercise1$solution,
                     collapse = '\n')
  ex_type <- l_out$exam1$exercise1$metainfo$type
  supplements <- l_out$exam1$exercise1$supplements

  #f_suppl <- fs::dir_ls(supplements)

  if (type_doc %in% c('latex', 'epub3')) {

    my_str <- stringr::str_glue(
      '\n\n {sprintf("%02d", my_counter)} - {exercise_text} \n\n '
    )

    if (ex_type == 'schoice') {
      n_alternatives <- length(alternatives)

      for (i_alt in seq(1, n_alternatives)) {
        my_str <- paste0(my_str,
                         letters[i_alt],') ', alternatives[i_alt],
                         '\n')
      }

      #browser()


    }


    cat(my_str)

  } else if (type_doc == 'html') {

    if (ex_type == 'schoice') {
      vec_mcq <- sample(
        c(alternatives[!correct],
          answer = alternatives[correct])
      )

      mcq_sc_answer <- webexercises::mcq(vec_mcq)
      my_answers_text <- stringr::str_glue('<br> Resposta: {mcq_sc_answer}')
      numeric_sol <- alternatives[correct]
      text_sol <- stringr::str_glue('A solução é {numeric_sol}. {text_pre_solution}')

    } else if (ex_type == 'num') {

      numeric_sol <- correct
      mcq_num_answer <- webexercises::fitb(correct)
      my_answers_text <- stringr::str_glue('<br><br> Resposta: {mcq_num_answer}')
      text_sol <- stringr::str_glue('A solução é {numeric_sol}. {text_pre_solution}')

    } else if (ex_type == 'string') {
      my_answers_text <- ''
      numeric_sol <- ''

      if (stringr::str_detect(solution,
                              '```text')) {
        text_sol <- stringr::str_glue('A solução pode ser encontrada pelo código abaixo. Para rodar, ',
                                      'abra um novo script no RStudio (Control+shift+N), copie e cole o código, e rode o ',
                                      'script apertando Control+Shift+Enter.')

      } else {
        text_sol <- ''
      }

    }


    my_str <- paste0('\n\n <hr> \n',
                     webexercises::total_correct(), '\n',
                     '### Q.', my_counter, '{-} \n',
                     exercise_text, '\n',
                     my_answers_text)


    temp_id <- basename(tempfile(pattern = 'collapse_'))
    sol_str <- stringr::str_glue(
      ' <div style="text-align: left; margin-top: 2px; padding: 13px 0 10px 0;"><p><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#{temp_id}" aria-expanded="false" aria-controls="collapseExample">
    Solução
  </button> </p> </div>

<div class="collapse" id="{temp_id}">
{text_sol}
  <div class="card card-body">
    {solution}
  </div>
</div>')

    cat(paste0(my_str, '\n' ,
               sol_str))

  }

  l_out <- list(supplements = supplements)


  return(l_out)

}


#' Builds text for answers
#'
#' Used in eoc TRUE/FALSE exercises
#'
#' @param text1 tibble for alternative 01
#' @param text2 tibblefor alternative 02
#' @param text3 tibble for alternative 03
#'
#' @return a list
#' @export
#'
#' @examples
#' text1 <- dplyr::tibble(text = c('O R é uma plataforma de programação madura e estável;',
#' 'O R foi desenvolvido em 2018 e é um projeto inovador e instável;'),
#' sol = c(TRUE, FALSE))
#'
#' text2 <- dplyr::tibble(text = c('O RStudio é uma interface ao R, aumentando a produtividade do analista;',
#' 'O RStudio é uma linguagem de programação alternativa ao R;'),
#'                       sol = c(TRUE, FALSE))
#'
#' text3 <- dplyr::tibble(text = c('O R tem compatibilidade com diferentes linguagens de programação;',
#' 'O R não tem compatibilidade com diferentes linguagens de programação;'),
#'                       sol = c(TRUE, FALSE))
#'
#' l <- build_answers_text(text1,
#' text2,
#' text3)
build_answers_text <- function(text1,
                               text2,
                               text3) {

  text1_chosen <- text1[sample(1:nrow(text1), 1), ]
  text2_chosen <- text2[sample(1:nrow(text2), 1), ]
  text3_chosen <- text3[sample(1:nrow(text3), 1), ]

  right_answer <- paste0(c(text1_chosen$sol,
                           text2_chosen$sol,
                           text3_chosen$sol), collapse = ', ')

  other_answers <- tidyr::expand_grid(col1 = c('TRUE', 'FALSE'),
                                      col2 = c('TRUE', 'FALSE'),
                                      col3 = c('TRUE', 'FALSE')) |>
    dplyr::mutate(answer = glue::glue('{col1}, {col2}, {col3}') ) |>
    dplyr::filter(answer != right_answer)

  my_answers <- c(right_answer,
                  sample(other_answers$answer, 4))

  check_answers(my_answers)

  return(list(my_answers = my_answers,
              texts = c(text1_chosen$text,
                        text2_chosen$text,
                        text3_chosen$text)))

}

#' Tests answers vector
#'
#' @noRd
check_answers <- function(answers_in) {

  n_answers <- 5
  if (length(answers_in) != n_answers) {
    stop('Found question with less or more than 5 answers..')
  }

  n_unique <- dplyr::n_distinct(answers_in)
  if (n_unique != n_answers) {
    stop('Found question with less or more than 5 UNIQUE answers..')
  }

  flag <- any(stringr::str_trim(answers_in) == '')
  if (flag) {
    stop('Found question with empty answer..')
  }

  if (is.numeric(answers_in)) {
    flag <- any(!is.finite(answers_in))

    if (flag) {
      stop('Found numeric question with non finite number..')
    }

  }

  return(invisible(TRUE))

}

#' Generate random weights for answers
#'
#' @noRd
gen_rnd_vec <- function(){
  rnd_vec_1 <- c(1, seq(stats::runif(1, 0.1, 0.2),
                        stats::runif(1, 0.7, 0.8),
                        length.out = 4))
  rnd_vec_2 <- c(1, seq(stats::runif(1,1.1,1.2),
                        stats::runif(1,1.7, 1.8),
                        length.out = 4))
  rnd_vec_3 <- c(1, seq(stats::runif(1,0.25,0.5),
                        stats::runif(1,0.6,0.8),
                        length.out = 2),
                 seq(stats::runif(1,1.2,2), length.out = 2))

  rnd_l <- list(rnd_vec_1, rnd_vec_2, rnd_vec_3)
  rnd_vec <- sample(rnd_l, 1)[[1]]

  return(rnd_vec)
}

#' Make random numeric answers
#'
#' @noRd
make_random_answers <- function(solution,
                                candidates = NA,
                                is_cash = FALSE) {
  if (!any(is.na(candidates))) {
    candidates <- unique(candidates)
    candidates <- candidates[candidates != solution]

    if (length(candidates) < 4) {
      stop('Candidate vector is lower than 4!')
    }

    my_answers <- c(solution,
                    sample(candidates, 4))
  } else {
    # check if is numeric
    if (class(solution) %in% c('numeric', 'integer')) {
      # find number of decimais
      n_decimals <- decimal_places(solution)

      if (n_decimals ==0) {
        my_answers <- floor(solution*gen_rnd_vec())
      } else {
        if (n_decimals > 4) n_decimals <- 4
        my_answers <- format(solution*gen_rnd_vec(),
                             digits = n_decimals)
      }

      if (is_cash) {
        my_answers <- format_cash(
          as.numeric(my_answers))
      }

    }

  }

  return(my_answers)
}

#' Get dir of exercise
#'
#' @param name_dir name of dir
#'
#' @return full path of dir
#' @export
#'
#' @examples
#' exercises_dir_get(exercises_dir_list()[1])
exercises_dir_get <- function(name_dir) {
  package_dir <- system.file("extdata/eoce",
                             package = "vdr")

  this_path <- fs::path(
    package_dir,
    name_dir
  )

  if (!fs::dir_exists(this_path)) {
    cli::cli_abort("Cant find dir {this_path}")
  }

  return(this_path)
}

#' Lists available eoc dir
#'
#' @return a char vector
#' @export
#'
#' @examples
#' exercises_dir_list()
exercises_dir_list <- function() {
  package_dir <- system.file("extdata/eoce",
                             package = "vdr")

  available_dirs <- basename(fs::dir_ls(package_dir))

  cli::cli_h3("List of available eoce")

  for (i_dir in available_dirs) {
    cli::cli_alert_info("{i_dir}")
  }

  return(invisible(available_dirs))
}
