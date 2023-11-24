#' Index phylo tree with specificic taxa names
#'
#' @param data_phylo 
#'
#' @return data_phylo indexed
#' @export
#'
#' @examples
id_phylo <- function(data_phylo) {
  names(data_phylo) <- c("Trees","Birds")
  return(data_phylo)
}