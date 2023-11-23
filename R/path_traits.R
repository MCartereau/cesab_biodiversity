#' Get traits data path
#'
#' @param filename 
#'
#' @return path
#'
#' @examples
path_traits <- function(filename) {
  path <- here::here("data", "raw-data",filename)
  return(path)
}