#' Load csv files
#' 
#'
#' @param filename indicates the name of the csv file you want to load
#'
#' @return the path 
#' 
load_csv <- function (filename) {
  path <- here::here("data", "raw-data")
  read.csv(paste0(path, '/', filename))
return(paste0(path, '/', filename))
} 