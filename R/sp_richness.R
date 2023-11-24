sp_richness <- function(variables) {
  
}

ataxo <- occ2 |>
  dplyr::group_by(Taxon, Idgrid) |>
  dplyr::summarize(alpha_taxo = dplyr::n()) |>
  dplyr::mutate(Dimension = "Alpha") |>
  dplyr::mutate(Facet = "Taxonomic") |>
  dplyr::rename(Value = alpha_taxo) |>
  dplyr::mutate(Variable = dplyr::case_when(Taxon == "Birds" ~ "ataxobird",
                              Taxon == "Trees" ~ "ataxotree")) %>%
  select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(ataxo)


test <- occ2 |>
  dplyr::group_by(Taxon, Idgrid) 
