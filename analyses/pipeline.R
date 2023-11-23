library(targets)
library(tarchetypes)

targets::tar_source(here::here("R"))

list(

## Create path --
tar_target(pathocc, path_occ("INTEGRADIV_occurrences_ex.csv"), format = "file"),
tar_target(pathtraits, path_occ("INTEGRADIV_traits_ex.csv"), format = "file"),
tar_target(pathphylo, path_occ("INTEGRADIV_phylogenies_ex.tree"), format = "file"),
tar_target(pathspatgrid, path_spat_grid("spgrid_50x50km_EUROMEDIT_EPSG3035.shp"), format = "file"),
  
  
## Read data--  
tar_target(load_occ, load_csv(pathocc)),
tar_target(load_traits, load_csv(pathtraits)),
tar_target(load_phylogeny, load_phylo(pathphylo)),
tar_target(load_spat, load_spat_grid(pathspatgrid)),


## Format data --

# Select occurrences in a 50x50 grid in the EUROMEDIT region
tar_target(select_occ, occ_select(load_occ, "50x50", "EUROMEDIT")),

# Format species-site matrix
tar_target(format_sp_tree_site, sp_site_mat(select_occ, "Tree")),
tar_target(format_sp_animal_site, sp_site_mat(select_occ, "Birds")),

# Functional traits selection
tar_target(select_tree_traits, ??? ) # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
tar_target(select_animal_traits, trait_select(c("Mass", "Clutch_MEAN", "Beak.Depth", "Beak.Width", "Tail.Length"))),

## Compute indices
# 
# # Species richness
tar_target(comp_sp_rich, sp_rich(select_occ)),

# Phylogenetic richness
tar_target(comp_tree_phylo_rich, phy_rich(format_sp_tree_site, "Tree")),
tar_target(comp_animal_phylo_rich, phy_rich(format_sp_animal_site, "Birds")),

# Functional richness
tar_target(comp_tree_func_rich, func_rich( ???, format_sp_tree_site, taxon_id = "Trees")), #!!!!!!!!!!!!!!!!!!
tar_target(comp_animal_func_rich, func_rich(select_animal_traits, format_sp_animal_site, taxon_id = "Trees")),
 

## Combine richness indices
 
tar_target(comb_ind_rich, ind_rich(comp_sp_rich, 
                                   comp_func_animal_rich, comp_func_tree_rich, 
                                   comp_phylo_animal_rich, comp_phylo_tree_rich)),
 
 
## Plot
 
tar_target(plot_map, plot_map(load_spat, comb_ind_rich, c("Trees", "Birds"))),
 

# ## Transpile report

tarchetypes::tar_quarto(index, path = here::here("index.qmd"))


)
