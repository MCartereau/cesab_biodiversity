#' Select functional traits we need
#'
#' @param traits_i is a vector of characters specifying the traits we want
#' @param data is the load_traits data 
#'
#' @return trait table with only the selected traits
#' 
traits_select <- function(data, traits_i) {
  
  traits_selected <- data |>
    dplyr::filter(Trait %in% traits_i) |>
    dplyr::mutate(Value = as.numeric(Value))
  
  return(traits_selected)
  
}
