#' Title
#'
#' @param data 
#' @param data_mat 
#' @param taxon_id 
#'
#' @return
#' @export
#'
#' @examples
#
func_rich <- function(data, data_mat, taxon_id) {
  
  data2 <- data %>%
    dplyr::select(c("Species", "Trait", "Value")) %>%
    tidyr::spread(Trait, Value)
  
  rownames(data2)<-data2$Species
  
  data2 <- data2 %>% dplyr::select(-Species)
  
  afuncbirds <- data2 %>% 
    log() %>%
    scale(., center=T, scale=T) %>%
    fundiversity::fd_fric(., data_mat) %>%
    dplyr::bind_cols(data_mat[,1]) %>%
    dplyr::rename(Idgrid = ...3) %>%
    dplyr::mutate(Variable = "afuncbird") %>%
    dplyr::mutate(Dimension = "Alpha") %>%
    dplyr::mutate(Facet = "Functional") %>%
    dplyr::mutate(Taxon = taxon_id) %>%
    dplyr::rename(Value = FRic) %>%
    dplyr::select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
}
