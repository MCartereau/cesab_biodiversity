#' Prepare and select occurrences data we need 
#'
#' @param data the data frame  
#' @param grid choose the resolution 
#' @param region choose the region
#'
#' @return the data frame we need for downstream analysis
#' 
occ_select <- function (data, grid, region) {
  
  data |>
    filter(Grid == grid) |>
    filter(Region == region) |>
    distinct(Taxon, Species, Idgrid)
}