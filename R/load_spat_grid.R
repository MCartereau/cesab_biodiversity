#' Load spatial grid
#' 
#'
#' @param path 
#'
#' @return spatial data
#' 
load_spat_grid <- function (path) {
  data <- sf::st_read(path)
  return(data)
} 