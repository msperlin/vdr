.onAttach <- function(libname,pkgname) {

  do_color <- crayon::make_style("#FF4141")
  this_pkg <- 'BatchGetSymbols'

  data_files <- list.files(
    system.file('extdata/data', package = 'vdr')
  )
  exerc_files <- list.files(
    system.file('extdata/eoc-exercises', package = 'vdr')
  )

  if (interactive()) {
    msg <- paste0('\nPackage vdr sucessfully loaded! ',
                  'Here youll find:\n\n',
                  '\t', length(data_files), ' data files \n',
                  '\t', length(exerc_files), ' exercises solutions \n'
                  )
  } else {
    msg <- ''
  }

  packageStartupMessage(msg)

}
