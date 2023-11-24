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
  alpha_div <- dplyr::bind_rows(dplyr::ungroup(data_tax), data_func_anim, data_func_trees, data_phy_anim, data_phy_trees) |>
    dplyr::ungroup() |>
    dplyr::select(c("Idgrid", "Variable", "Value")) |>
    tidyr::spread(Variable, Value) |>
    dplyr::filter(ataxobird >= 5 | ataxotree >= 5) |>
    na.omit() |>
    dplyr::mutate(dplyr::across(afuncBirds:ataxotree, heatmaply::normalize)) |> 
    tidyr::pivot_longer(!Idgrid, names_to="Variable", values_to = "Value") |>
    dplyr::mutate(Dimension = "Alpha") |>
    dplyr::mutate(Facet = dplyr::case_when(grepl("func", Variable) ~ "Functional",
                             grepl("taxo", Variable) ~ "Taxonomic",
                             grepl("phylo", Variable) ~ "Phylogenetic")) |>
    dplyr::mutate(Taxon = dplyr::case_when(grepl("ird", Variable) ~ "Birds",
                             grepl("ree", Variable) ~ "Trees")) 
}
