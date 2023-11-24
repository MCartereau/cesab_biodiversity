#' cesab_biodiversity: Biodiversity facets of birds and tree species across the Euro-Mediterranean Basin.
#' 
#' @description 
#' This project aims to map biodiversity facets (taxonomic, functional and phylogenetic) 
#' for both breeding birds and trees across the Euro-Mediterranean Basin.
#' 
#' @author Manuel Cartereau \email{manuel.cartereau@gmail.com}
#' 
#' @date 2023/11/23


## Install Dependencies (listed in DESCRIPTION) ----

#devtools::install_deps(upgrade = "never")
renv::install()

## Load Project Addins (R Functions and Packages) ----

devtools::load_all(here::here())

## Configuration targets
targets::tar_config_set(
  store = "outputs/pipeline",
  script = "analyses/pipeline.R"
)


## Global Variables ----

# You can list global variables here (or in a separate R script)


## Run Project ----

# List all R scripts in a sequential order and using the following form:
# source(here::here("analyses", "script_X.R"))

targets::tar_visnetwork()

targets::tar_make()


