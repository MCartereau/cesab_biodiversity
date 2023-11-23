#' Title
#'
#' @param data 
#'
#' @return
#' @export
#'
#' @examples

sp_rich <- function(data) {
  data|>
    dplyr::group_by(Taxon, Idgrid) |> 
    dplyr::summarize(ataxo = dplyr::n()) |>
    dplyr::mutate(Dimension = "Alpha") |>
    dplyr::mutate(Facet = "Taxonomic") |>
    dplyr::rename(Value = ataxo) |>
    dplyr::mutate(Variable = dplyr::case_when(Taxon == "Birds" ~ "ataxobird",
                                Taxon == "Trees" ~ "ataxotree")) |>
    dplyr::select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
}


