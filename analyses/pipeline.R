library(targets)
library(tarchetypes)

targets::tar_source(here::here("R"))

list(

## Create path and read data--
tar_target(load-occ, load_csv("INTEGRADIV_occurrences_ex.csv"), format = "file" ),
tar_target(load-traits, load_csv("INTEGRADIV_traits_ex.csv"), format = "file" ),
tar_target(load-phylo, load_phylo("INTEGRADIV_phylogenies_ex.csv"), format = "file" ),
tar_target(load-spat, load_spat_grid("spgrid_50x50km_EUROMEDIT_EPSG3035.shp"), format = "file" ),

## Format data --

# Select occurrences in a 50x50 grid in the EUROMEDIT region
tar_target(select-occ, occ_select(load_occ, "50x50", "EUROMEDIT")),

# 
tar_target(format-sp-site, sp_site_mat(select-occ, )),
tar_target(),

  
  
)