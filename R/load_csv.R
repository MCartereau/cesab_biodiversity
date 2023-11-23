#' Load csv files
#' 
#'
#' @param path 
#'
#' @return data
#' 
load_csv <- function (path) {
  data <- utils::read.csv(path)
return(data)
} 