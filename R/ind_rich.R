#' Title
#'
#' @param data_tax 
#' @param data_func_anim 
#' @param data_func_trees 
#' @param data_phy_anim 
#' @param data_phy_trees 
#'
#' @return
#' @export
#'
#' @examples

ind_rich <- function(data_tax, data_func_anim, data_func_trees, data_phy_anim, data_phy_trees) {
  alpha_div <- dplyr::bind_rows(data_tax, data_func_anim, data_func_trees, data_phy_anim, data_phy_trees) |>
    dplyr::ungroup() |>
    dplyr::select(c("Idgrid", "Variable", "Value")) |>
    tidyr::spread(Variable, Value) |>
    dplyr::filter(ataxobird >= 5 | ataxotree >= 5) |>
    na.omit() |>
    dplyr::mutate(dplyr::across(afuncbird:ataxotree, normalize)) |> 
    tidyr::pivot_longer(!Idgrid, names_to="Variable", values_to = "Value") |>
    dplyr::mutate(Dimension = "Alpha") |>
    dplyr::mutate(Facet = case_when(grepl("func", Variable) ~ "Functional",
                             grepl("taxo", Variable) ~ "Taxonomic",
                             grepl("phylo", Variable) ~ "Phylogenetic")) |>
    dplyr::mutate(Taxon = case_when(grepl("bird", Variable) ~ "Birds",
                             grepl("tree", Variable) ~ "Trees")) 
}
