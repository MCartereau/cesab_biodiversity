#' Load tree files
#' 
#' @param filename 
#'
#' @return tree data
#' 
load_phylo <- function(path) {
  data <- ape::read.tree(path)
  return(data)
} 