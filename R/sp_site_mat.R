#' Function to produce a site vs sp matrix
#'
#' @param data is the data input as the output of the occ_select function
#' @param taxon_to_filter among "Birds" or "Trees"
#'
#' @return matrix site vs sp matrix
#' @export
#'
#' @examples
sp_site_mat <- function(data, taxon_to_filter) {
  
  matrix <- data |>
    dplyr::filter(Taxon == taxon_to_filter) |>
    dplyr::mutate(Presence = 1) |>
    dplyr::select(-1) |>
    tidyr::spread(Species, Presence, fill = 0)
 return(matrix)
}
