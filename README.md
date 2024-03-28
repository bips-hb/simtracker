# simtracker: A Simulation Tracking Package for R

## Overview

The `simtracker` package is designed to facilitate the tracking and management of simulation studies in `R`. Originally intended for use on the workstation in our institute, it can be used on 
your local machine as well. The package is currently a work in progress.

## Motivation

The development of `simtracker` arises from the need to move away from `batchtools`, the previous preferred method for cluster computations, which is no longer suitable for the workstation. Instead, the package leverages the R package `parallel` and provides wrapper functions for setting up the cluster object, making it easier to manage and keep track of simulation studies.

## Features

- **Simulation Registry**: Create a registry in the form of the 'simulations' folder to keep track of completed simulation runs based on parameter settings.
- **Results Storage**: Store the results of individual runs in the 'simulations/results' folder.
- **Seed Tracking**: Store the seed with which the simulation has run for each parameter setting, making results reproducible.
- **Keeping Track of Finished Runs**: Runs of the simulation that already ran are not repeated.

## Installation

You can install `simtracker` from GitHub using the following:

```R
devtools::install_github("bips-hb/simtracker")
```

## Usage

See the script `example.R` for an extended example of how to use the `simtracker`
package. 

You can check up on the progress of the simulation by running

```R
simtracker::check_progress()
```

An example using the package `ranger`: 

```R
# Load the 'simtracker' package for simulation tracking
library(simtracker)

# Set up the simulation directory
simtracker::setup_simulation("simulation-name")

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
simtracker::run_simulation_study(cl, sim_fn)

# Processes the results from the simulation study
simtracker::process_results_simulation(cl, process_fn)

# Stop and clean up the parallel cluster
simtracker::stop_cluster(cl)

# Uncomment the line below to delete the entire simulation directory (use with caution)
# simtracker::reset_simulation()
```

## Contact

For questions or suggestions on how to improve `simtracker`, please contact [dijkstra@leibniz-bips.de](mailto:dijkstra@leibniz-bips.de).

## Note

The current version of `simtracker` is for internal use only but will be made publicly available later on.

Feel free to customize and expand this template to include more detailed documentation about the package's functions, parameters, and usage examples.
