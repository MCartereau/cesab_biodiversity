############## Packages

library(tidyverse)
library(magrittr)
library(sf)
library(data.table)
library(ape)
library(picante)
library(heatmaply)
library(fundiversity)

############## Load data

occ <- fread("inputs/INTEGRADIV_occurrences_v1.csv")
head(occ); dim(occ)

trait <- fread("inputs/INTEGRADIV_traits_v2.csv")
head(trait); dim(trait)
trait %>% pull(Trait) %>% as.factor() %>% levels()

phylo <- read.tree("inputs/INTEGRADIV_phylogenies_v1.tree")
str(phylo)
phylo[[1]]
phylo[[2]]

grid <- st_read("inputs/50x50_EUROMEDIT/spgrid_50x50km_EUROMEDIT_EPSG3035.shp")["GRD_ID"]
plot(grid)

ctrait <- readRDS("inputs/TREES_sp_tr_Camille.rds")
head(ctrait); dim(ctrait)
summary(ctrait)
class(ctrait)

############## Format data

occ2 <- occ %>%
	  filter(Grid == "50x50") %>%
	  filter(Region == "EUROMEDIT") %>%
	  distinct(Species, Idgrid, .keep_all=T) %>%
	  select(c("Taxon", "Species", "Idgrid"))
head(occ2); dim(occ2)

trait_birds <- trait %>%
		   filter(Taxon == "Birds") %>%
		   filter(Trait %in% c("Mass", "Clutch_MEAN", "Beak.Depth", "Beak.Width", "Tail.Length")) %>%
		   mutate(Value = as.numeric(Value))
head(trait_birds); dim(trait_birds) 

############## Compute biodiversity metrics

##### Alpha - Taxonomic  

ataxo <- occ2 %>%
	   group_by(Taxon, Idgrid) %>%
	   summarize(ataxo = n()) %>%
	   mutate(Dimension = "Alpha") %>%
	   mutate(Facet = "Taxonomic") %>%
	   rename(Value = ataxo) %>%
	   mutate(Variable = case_when(Taxon == "Birds" ~ "ataxobird",
						 Taxon == "Trees" ~ "ataxotree")) %>%
	   select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(ataxo)

##### Alpha - Functional 

mattrees2 <- occ2 %>%
		 filter(Taxon == "Trees") %>%
		 mutate(Presence = 1) %>%
		 select(-1) %>%
		 spread(Species, Presence) %>%
		 replace(is.na(.), 0) %>%
		 as.data.frame.matrix()
head(mattrees2); dim(mattrees2)

afunctrees <- ctrait %>% 
		  log() %>%
		  scale(., center=T, scale=T) %>%
		  fd_fric(., mattrees2) %>%
		  bind_cols(mattrees2[,1]) %>%
		  rename(Idgrid = ...3) %>%
		  mutate(Variable = "afunctree") %>%
		  mutate(Dimension = "Alpha") %>%
		  mutate(Facet = "Functional") %>%
		  mutate(Taxon = "Trees") %>%
		  rename(Value = FRic) %>%
		  select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(afunctrees); dim(afunctrees)

matbirds2 <- occ2 %>%
		 filter(Taxon == "Birds") %>%
		 mutate(Presence = 1) %>%
		 select(-1) %>%
		 spread(Species, Presence) %>%
		 replace(is.na(.), 0) %>%
		 as.data.frame.matrix()
head(matbirds2); dim(matbirds2)

traits_birds2 <- trait_birds %>%
		     select(c("Species", "Trait", "Value")) %>%
		     spread(Trait, Value)
rownames(traits_birds2)<-traits_birds2$Species
traits_birds2 <- traits_birds2 %>% select(-Species)
head(traits_birds2)
head(ctrait)

afuncbirds <- traits_birds2 %>% 
		  log() %>%
		  scale(., center=T, scale=T) %>%
		  fd_fric(., matbirds2) %>%
		  bind_cols(matbirds2[,1]) %>%
		  rename(Idgrid = ...3) %>%
		  mutate(Variable = "afuncbird") %>%
		  mutate(Dimension = "Alpha") %>%
		  mutate(Facet = "Functional") %>%
		  mutate(Taxon = "Birds") %>%
		  rename(Value = FRic) %>%
		  select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(afuncbirds); dim(afuncbirds)

##### Alpha - Phylo

mattrees <- occ2 %>%
		filter(Taxon == "Trees") %>%
		mutate(Species = sub(Species, pattern=" ", replacement="_")) %>%
		mutate(Presence = 1) %>%
		select(-1) %>%
		spread(Species, Presence) %>%
		replace(is.na(.), 0) 
head(mattrees); dim(mattrees)

aphyltrees <- mattrees %>% 
		  select(-Idgrid) %>%
		  as.matrix() %>%
		  pd(., phylo[[1]], include.root=FALSE) %>%
		  bind_cols(mattrees[,1]) %>%
		  rename(Idgrid = ...3) %>%
		  mutate(Variable = "aphylotree") %>%
		  mutate(Dimension = "Alpha") %>%
		  mutate(Facet = "Phylogenetic") %>%
		  mutate(Taxon = "Trees") %>%
		  rename(Value = PD) %>%
		  select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(aphyltrees); dim(aphyltrees)

matbirds <- occ2 %>%
		filter(Taxon == "Birds") %>%
		mutate(Species = sub(Species, pattern=" ", replacement="_")) %>%
		mutate(Presence = 1) %>%
		select(-1) %>%
		spread(Species, Presence) %>%
		replace(is.na(.), 0) 
head(matbirds); dim(matbirds)

aphylbirds <- matbirds %>% 
		  select(-Idgrid) %>%
		  as.matrix() %>%
		  pd(., phylo[[2]], include.root=FALSE) %>%
		  bind_cols(matbirds[,1]) %>%
		  rename(Idgrid = ...3) %>%
		  mutate(Variable = "aphylobird") %>%
		  mutate(Dimension = "Alpha") %>%
		  mutate(Facet = "Phylogenetic") %>%
		  mutate(Taxon = "Birds") %>%
		  rename(Value = PD) %>%
		  select(c("Idgrid", "Value", "Variable", "Dimension", "Facet", "Taxon"))
head(aphylbirds); dim(aphylbirds)

##### Combine alpha diversities

alpha_div <- bind_rows(ataxo, afuncbirds, afunctrees, aphylbirds, aphyltrees) %>%
		 ungroup() %>%
		 select(c("Idgrid", "Variable", "Value")) %>%
		 spread(Variable, Value) %>%
		 filter(ataxobird >= 5 | ataxotree >= 5) %>%
		 na.omit() %>%
		 mutate(across(afuncbird:ataxotree, normalize)) %>% 
		 pivot_longer(!Idgrid, names_to="Variable", values_to = "Value") %>%
		 mutate(Dimension = "Alpha") %>%
		 mutate(Facet = case_when(grepl("func", Variable) ~ "Functional",
						  grepl("taxo", Variable) ~ "Taxonomic",
					        grepl("phylo", Variable) ~ "Phylogenetic")) %>%
		 mutate(Taxon = case_when(grepl("bird", Variable) ~ "Birds",
					        grepl("tree", Variable) ~ "Trees")) 
		 
head(alpha_div); dim(alpha_div)
summary(alpha_div)
alpha_div %>% pull(Idgrid) %>% as.factor() %>% nlevels()

print(alpha_div, n=700)
plot(alpha_div$afuncbird[,1], alpha_div$afunctree[,1])
plot(alpha_div$ataxobird[,1], alpha_div$ataxotree[,1])
hist(alpha_div$afuncbird[,1])
hist(alpha_div$aphylobird[,1])
hist(alpha_div$ataxobird[,1])
hist(alpha_div$afunctree[,1])
hist(alpha_div$aphylotree[,1])
hist(alpha_div$ataxotree[,1])

##### Map alpha diversities

map <- left_join(grid, alpha_div, by=join_by(GRD_ID == Idgrid)) %>%
	 na.omit()
map 

fig <- 
ggplot(map %>%
       mutate(Facet_f = factor(Facet, levels=c("Taxonomic", "Phylogenetic", "Functional"))) %>%
       mutate(Taxon_f = factor(Taxon, levels=c("Trees", "Birds")))) +
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

fig

ggsave(plot=fig, filename="fig.png", device="png", dpi=800)

map %>%
filter(Facet=="Functional" & Taxon=="Trees") %>%
pull(Value) %>%
median()




