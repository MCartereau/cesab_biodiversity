#' Index phylo tree with specificic taxa names
#'
#' @param data_phylo phylogenetic data as tree file
#' @param filename name of the indexed file
#'
#' @return data_phylo indexed
#' @export
#'
#' @examples
id_phylo <- function(data_phylo, filename) {
  names(data_phylo) <- c("Trees","Birds")
  ape::write.tree(data_phylo, here::here("data","derived-data",filename))
  return(data_phylo)
}
