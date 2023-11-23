#' Title
#'
#' @param grid 
#' @param alpha_div 
#' @param taxon 
#'
#' @return
#' @export
#'
#' @examples
#' 

plot_map <- function(grid, alpha_div, taxon_ids) {
  map <- left_join(grid, alpha_div, by=join_by(GRD_ID == Idgrid)) %>%
    na.omit()
  
  fig <- 
    ggplot(map %>%
             mutate(Facet_f = factor(Facet, levels=c("Taxonomic", "Phylogenetic", "Functional"))) %>%
             mutate(Taxon_f = factor(Taxon, levels=c(taxon)))) +
    geom_sf(aes(fill = Value)) +
    scale_fill_gradient2(low="darkgoldenrod1", high="darkcyan", mid="white", midpoint=0.5) +
    facet_grid(Facet_f~Taxon_f) +
    theme(strip.text = element_text(size = 12, face="bold")) +
    theme(legend.position = "right")  +
    theme(legend.title=element_text(size=12, face="bold")) +
    theme(axis.text=element_text(size=12), 
          axis.title=element_text(size=12, face="bold")) +
    theme(strip.text.x = element_text(size = 12, face="bold")) +
    labs(x= "Longitude (EPSG 3035)", y="Latitude (EPSG 3035)", fill= "Biodiversity") +
    theme(panel.grid.major = element_line(colour = "lightgrey")) +
    theme(panel.background = element_rect(fill = NA, colour = "black"))
  
  return(fig)
}