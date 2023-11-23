#' Title
#'
#' @param data 
#' @param phylo_data 
#' @param taxon_id 
#'
#' @return
#' @export
#'
#' @examples

phy_rich <- function(data, phylo_data, taxon_id) {
  mat <- data|>
    select(-Idgrid) |>
    as.matrix()
  
  picante::pd(mat, phylo_data[[1]], include.root=FALSE) |>
    dplyr::bind_cols(data[,1]) |>
    dplyr::rename(Idgrid = ...3) |>
    dplyr::mutate(Variable = "aphylotree") |>
    dplyr::mutate(Dimension = "Alpha") |>
    dplyr::mutate(Facet = "Phylogenetic") |>
    dplyr::mutate(Taxon = taxon_id) |>
    dplyr::rename(Value = PD) |>
    dplyr::select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
  
}
