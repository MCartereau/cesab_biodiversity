sp_site_mat <- function (data, taxon) {
  data |> 
  dplyr::filter(Taxon %in% taxon) |> 
  dplyr::mutate(Presence = 1) |>
  dplyr::select(-1) |>
  tidyr::spread(Species, Presence) |>
  replace(is.na(.), 0) |>
  as.data.frame.matrix()
}