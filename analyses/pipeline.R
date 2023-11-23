library(targets)
library(tarchetypes)

targets::tar_source(here::here("R"))

list(

## Create path and read data--
tar_target(load_occ, load_csv("INTEGRADIV_occurrences_ex.csv"), format = "file" ),
tar_target(load_traits, load_csv("INTEGRADIV_traits_ex.csv"), format = "file" ),
tar_target(load_phylo, load_phylo("INTEGRADIV_phylogenies_ex.csv"), format = "file" ),
tar_target(load_spat, load_spat_grid("spgrid_50x50km_EUROMEDIT_EPSG3035.shp"), format = "file" ),


## Format data --

# Select occurrences in a 50x50 grid in the EUROMEDIT region
tar_target(select_occ, occ_select(load_occ, "50x50", "EUROMEDIT")),

# Format species-site matrix
tar_target(format_sp_site, sp_site_mat(select-occ, )),

# Functional traits selection
tar_target(select_traits, trait_select()),


## Compute indices

# Species richness
tar_target(comp_sp_rich, ),

# Phylogenetic richness
tar_target(comp_phylo_rich, ),

# Functional richness
tar_target(comp_func_rich, ),


## Combine richness indices

tar_target(comb_ind_rich, ),


## Plot

tar_target(plot_map, ),


## Transpile report

tar_target(t_report, ),

  
)