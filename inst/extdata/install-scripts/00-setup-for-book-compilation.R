# script for setting up R for book compilation
#   * install all cran pkgs
#   * install all github packages

book_folder <- "~/GDrive/06-books/04-Vis-Data-KDP/02-book-content-vdr/"
required_pkgs <- c("renv", "remotes")

installed_pkgs <- installed.packages()[, 1]

for (i_pkg in required_pkgs) {

  if (!i_pkg %in% installed_pkgs) install.package(i_pkg)
}

cran_pkgs <- unique(
  c(renv::dependencies(path = book_folder,
                       progress = FALSE)$Package,
    # other pkgs (not found by renv)
    "plotly",
    "DiagrammeR",
    "grid",
    "base",
    "paletteer",
    "hrbrthemes",
    "sf"
  )
)

# install all git pkgs
git_pkgs <- c(
  'msperlin/vdr',
  'msperlin/yfR',
  'clauswilke/dviz.supp',
  'clauswilke/colorblindr',
  "bbc/bbplot",
  "ricardo-bion/ggtech",
  "datarootsio/artyfarty"
)

# temporary solutions for some pkgs
devtools::install_github("ipeaGIT/geobr", subdir = "r-package")

if (!require(colorspace)) {
  install.packages("colorspace",
                   repos="http://R-Forge.R-project.org")
}

for (i_pkg in git_pkgs) {

  this_pkg <- stringr::str_split(i_pkg, '/')[[1]][2]
  if (!i_pkg %in% installed_pkgs) devtools::install_github(i_pkg)

}

# install req pkgs
temp <- lapply(cran_pkgs, function(pkg) {
  if (system.file(package = pkg) == '') install.packages(pkg)
})
