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
        text_sol <- stringr::str_glue('<p>A solução pode ser encontrada pelo código abaixo. Para rodar, ',
                                      'abra um novo script no RStudio (Control+shift+N), copie e cole o código, e rode o ',
                                      'script apertando Control+Shift+Enter.</p>')

      } else {
        text_sol <- ''
      }

    }

    my_str <- paste0('\n\n <hr> \n',
                     #webexercises::total_correct(), '\n',
                     '### Q.', my_counter, '{-} \n',
                     exercise_text, '\n',
                     my_answers_text)

    temp_id <- basename(tempfile(pattern = 'collapse_'))
    sol_str <- stringr::str_glue(
      ' <div style="text-align: left; margin-top: 2px; padding: 13px 0 10px 0;"><p><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#{temp_id}" aria-expanded="false" aria-controls="collapseExample">
    Clique para a solução
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


  return(invisible(l_out))

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
#' @param silent be silent?
#' @return a char vector
#' @export
#'
#' @examples
#' exercises_dir_list()
exercises_dir_list <- function(silent = FALSE) {
  package_dir <- system.file("extdata/eoce",
                             package = "vdr")

  available_dirs <- basename(fs::dir_ls(package_dir))

  if (!silent) {
    cli::cli_h3("List of available eoce")

    for (i_dir in available_dirs) {
      cli::cli_alert_info("{i_dir}")
    }
  }

  return(invisible(available_dirs))
}

#' Compiles solution of exercises
#'
#' This function will compile the solution of exercises from the book to
#' a .html file. Aternativelly, all solutiona are available at <www.msperlin.com/vdr>
#'
#' @param dir_output directory where to copy html file (e.g. '~/Desktop')
#'
#' @return nothing..
#' @export
#'
#' @examples
#'
#' exercises_compile_solution(dir_output = fs::path_temp())
exercises_compile_solution <- function(dir_output = "~/vdr-solutions") {
  fs::dir_create(dir_output)

  dir_exercises <- exercises_dir_list(TRUE)

  l_exerc <- purrr::map(
    dir_exercises, function(x) fs::dir_ls(exercises_dir_get(x))
    )

  f_exerc <- do.call(c, l_exerc)

  temp_dir <- f_out <- fs::file_temp('eoc-compilation')
  fs::dir_create(temp_dir)

  html_template <-   fs::path(system.file("extdata/templates",
                                          package = "vdr"),
                              "html_template.html")

  cli::cli_alert_info("Compilando soluções de exercícios")
  exams::exams2html(f_exerc, n = 1,
                    solution = TRUE,
                    dir = temp_dir,
                    template = html_template)

  # copy files
  f_out <- stringr::str_glue(
    '{format(Sys.time(), "%Y%m%d %H%M%S")}-Soluções-Exercícios-VDR.html'
  )

  cli::cli_alert_info("Copiando arquivos")
  fs::file_copy(
    fs::dir_ls(temp_dir),
    fs::path(dir_output, f_out),
    overwrite = TRUE
  )

  cli::cli_alert_success("Sucesso!")

  cli::cli_alert_info("Arquivo disponível em {fs::path_expand(fs::path(dir_output, f_out))}")
  cli::cli_alert_info("Localize o arquivo no seu navegador preferido e abra-o com dois cliques em um browser de internet.")

  return(invisible(TRUE))

}
