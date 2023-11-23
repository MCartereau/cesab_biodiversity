#' Select functional traits we need
#'
#' @param traits_i is a vector of characters specifying the traits we want
#'
#' @return trait table with only the selected traits
#' 
traits_select <- function(traits,traits_i) {
  
  traits_selected <- traits |>
    dplyr::filter(Trait %in% traits_i) |>
    dplyr::mutate(Value = as.numeric(Value))
  
  return(traits_selected)
  
}
