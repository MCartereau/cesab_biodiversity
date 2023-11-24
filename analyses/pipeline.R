library(targets)
library(tarchetypes)

targets::tar_source(here::here("R"))

list(

## 1 - Create path --------------------------------------------------------
tar_target(pathocc, path_occ("INTEGRADIV_occurrences_ex.csv"), format = "file"),
tar_target(pathtraits, path_occ("INTEGRADIV_traits_ex.csv"), format = "file"),
tar_target(pathphylo, path_occ("INTEGRADIV_phylogenies_ex.tree"), format = "file"),
tar_target(pathspatgrid, path_spat_grid("spgrid_50x50km_EUROMEDIT_EPSG3035.shp"), format = "file"),
  
  
## 2 - Read data ---------------------------------------------------------
tar_target(load_occ, load_csv(pathocc)),
tar_target(load_traits, load_csv(pathtraits)),
tar_target(load_phylogeny, load_phylo(pathphylo)),
tar_target(load_spat, load_spat_grid(pathspatgrid)),


## 3 - Format data ------------------------------------------------------

# 3.1 - Transform phylo data : index multifile as taxon names

tar_target(id_phy, id_phylo(load_phylogeny, "load_phylogeny_mod.tree")),

# 3.2 - Select occurrences in a 50x50 grid in the EUROMEDIT region
tar_target(select_occ, occ_select(load_occ, "50x50", "EUROMEDIT")),

# 3.2 - Format species-site matrix
tar_target(format_sp_tree_func_site, sp_site_mat_func(select_occ, "Trees")),
tar_target(format_sp_animal_func_site, sp_site_mat_func(select_occ, "Birds")),
tar_target(format_sp_tree_phylo_site, sp_site_mat_phylo(select_occ, "Trees")),
tar_target(format_sp_animal_phylo_site, sp_site_mat_phylo(select_occ, "Birds")),


## 4 - Functional traits selection ---------------------------------------
tar_target(select_animal_traits, traits_select(load_traits, c("Mass", "Clutch_MEAN", "Beak.Depth", "Beak.Width", "Tail.Length"))),
tar_target(select_tree_traits, traits_select(load_traits, c("LA", "SLA", "SeedMass", "StemSpecDens", "HeightMax"))),

## 5 - Compute indices --
# 
# 5.1 - Species richness
tar_target(comp_sp_rich, sp_rich(select_occ)),

# 5.2 - Phylogenetic richness
tar_target(comp_phylo_tree_rich, phy_rich(format_sp_tree_phylo_site, id_phy, taxon_id = "Trees")),
tar_target(comp_phylo_animal_rich, phy_rich(format_sp_animal_phylo_site, id_phy, taxon_id = "Birds")),

# 5.3 - Functional richness
tar_target(comp_func_tree_rich, func_rich(select_tree_traits, format_sp_tree_func_site, taxon_id = "Trees")),
tar_target(comp_func_animal_rich, func_rich(select_animal_traits, format_sp_animal_func_site, taxon_id = "Birds")),

## 5 - Combine richness indices --------------------------------------------
 
tar_target(comb_ind_rich, ind_rich(comp_sp_rich, 
                                   comp_func_animal_rich, comp_func_tree_rich, 
                                   comp_phylo_animal_rich, comp_phylo_tree_rich)),
 
 
## Plot
 
tar_target(plot, plot_map(load_spat, comb_ind_rich, c("Trees", "Birds")))
 

# ## Transpile report

# tarchetypes::tar_quarto(index, path = here::here("index.qmd"))


)
