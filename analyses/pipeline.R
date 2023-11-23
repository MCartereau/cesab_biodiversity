library(targets)
library(tarchetypes)

targets::tar_source(here::here("R"))

list(

## Create path --
tar_target(pathocc, path_occ("INTEGRADIV_occurrences_ex.csv"), format = "file"),
tar_target(pathtraits, path_occ("INTEGRADIV_traits_ex.csv"), format = "file"),
tar_target(pathphylo, path_occ("INTEGRADIV_phylogenies_ex.csv"), format = "file"),
tar_target(pathspatgrid, path_spat_grid("spgrid_50x50km_EUROMEDIT_EPSG3035.shp"), format = "file"),
  
  
## Read data--  
tar_target(load_occ, load_csv(pathocc),
tar_target(load_traits, load_csv(pathtraits)),
tar_target(load_phylo, load_phylo(pathphylo)),
tar_target(load_spat, load_spat_grid(pathspatgrid)),


# 
# ## Format data --
# 
# # Select occurrences in a 50x50 grid in the EUROMEDIT region
# tar_target(select_occ, occ_select(load_occ, "50x50", "EUROMEDIT")),
# 
# # Format species-site matrix
# tar_target(format_sp_site, sp_site_mat(select-occ, )),
# 
# # Functional traits selection
# tar_target(select_traits, trait_select()),
# 
# 
# ## Compute indices
# 
# # Species richness
# tar_target(comp_sp_rich, ),
# 
# # Phylogenetic richness
# tar_target(comp_phylo_rich, ),
# 
# # Functional richness
# tar_target(comp_func_rich, ),
# 
# 
# ## Combine richness indices
# 
# tar_target(comb_ind_rich, ),
# 
# 
# ## Plot
# 
# tar_target(plot_map, ),
# 
# 
# ## Transpile report
# 
# tar_target(t_report, ),
# 
#   
)