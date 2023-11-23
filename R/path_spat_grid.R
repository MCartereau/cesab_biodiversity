#' Path spatial grid
#'
#' @param filename 
#'
#' @return pathfile
#' @export
#'
#' @examples
path_spat_grid <- function(filename) {
  path <- here::here("data", "raw-data","50x50_EUROMEDIT",filename)
  return(path)
}