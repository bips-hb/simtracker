# Load the 'simtracker' package for simulation tracking
library(simtracker)

# Set up the simulation directory
simtracker::setup_simulation("ranger-performance")

# Example tibble with parameter settings
parameter_settings <- tibble(expand.grid(
    n_obs = c(100,500,1000),
    n_vars = c(10,50,100)
  )
)

# Number of repetitions for each set of parameters
n_repetitions <- 10

# Number of parallel workers to use (max. is 50)
n_workers <- 2

# Initialize simulation settings based on the provided parameter settings and repetitions
simulation_settings <- simtracker::initialize_simulation_settings(parameter_settings, n_repetitions)

# If the simulation settings were already initialized, one can also use this function
# simulation_settings <- simtracker::load_simulation_settings()

# Load the function applied to each parameter setting
source("simulation-function.R")
source("process-function.R")

# Set up a parallel cluster for parallel processing
cl <- simtracker::create_cluster(
  list_needed_functions_variables = list("simulation_settings",
                                         "sim_fn",
                                         "process_fn"),
  num_workers = n_workers,
  cluster_type = 'PSOCK' # Default for the workstation. See additional comments
)

# Load necessary libraries on each worker in the parallel cluster
# IMPORTANT: There are no comma's between the libraries
parallel::clusterEvalQ(cl, {
  library(MASS)       # Import the 'MASS' package
  library(tidyverse)  # Import the 'tidyverse' package
  library(ranger)
})

# Run the simulation study using the specified function
simtracker::run_simulation_study(cl = NULL, sim_fn)

# Processes the results from the simulation study
simtracker::process_results_simulation(cl, process_fn)

# Stop and clean up the parallel cluster
simtracker::stop_cluster(cl)

# Uncomment the line below to delete the entire simulation directory (use with caution)
# simtracker::reset_simulation()
