#' Load spatial grid
#' 
#'
#' @param filename indicates the name of the spatial grid you want to load
#'
#' @return the path 
#' 
load_spat_grid <- function (filename) {
  path <- here::here("data", "raw-data")
  sf::st_read(paste0(path, '/', filename))
  return(paste0(path, '/', filename))
} 