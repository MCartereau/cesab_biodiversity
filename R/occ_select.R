#' Prepare and select occurrences data we need 
#'
#' @param grid_i choose the resolution, option are c("50x50","10x10")
#' @param region_i choose the region, option is "EUROMEDIT"
#' @param data the data frame  
#'
#' @return the data frame we need for downstream analysis
#' 
occ_select <- function (data, grid_i, region_i) {
  
  clear_data <- data |>
    dplyr::filter(Grid == grid_i) |>
    dplyr::filter(Region == region_i) |>
    dplyr::distinct(Taxon, Species, Idgrid)

  return(clear_data)
}