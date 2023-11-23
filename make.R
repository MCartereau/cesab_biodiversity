#' cesab_biodiversity: A Research Compendium
#' 
#' @description 
#' A paragraph providing a full description of the project and describing each 
#' step of the workflow.
#' 
#' @author Manuel Cartereau \email{manuel.cartereau@gmail.com}
#' 
#' @date 2023/11/23


## Install Dependencies (listed in DESCRIPTION) ----

devtools::install_deps(upgrade = "never")


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

<<<<<<< HEAD
tar_make()
=======
# Load targets files 

target_description <- read.csv(here::here("analyses","Targets.csv"))
>>>>>>> 5ab5333bc6ff061c22e90fa8596cc947b9d759b6
