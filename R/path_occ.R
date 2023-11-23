#' Get occurence data path
#'
#' @param filename 
#'
#' @return path
#'
#' @examples
path_occ <- function(filename) {
  path <- here::here("data", "raw-data",filename)
  return(path)
}