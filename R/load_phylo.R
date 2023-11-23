#' Load tree files
#' 
#'
#' @param filename indicates the name of the tree file you want to load
#'
#' @return the path 
#' 
load_phylo <- function (filename) {
  path <- here::here("data", "raw-data")
  ape::read.tree(paste0(path, '/', filename))
  return(paste0(path, '/', filename))
} 