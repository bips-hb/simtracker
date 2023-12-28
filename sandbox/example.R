library(simtracker)


# Set-up the simulation directory ----------------------------
simtracker::setup_simulation("hello-world")

# Example tibble with parameter settings
parameter_settings <- tibble(
  param1 = c("value1", "value2", "value3"),
  param2 = c(10, 20, 30),
  param3 = c("outputA", "outputB", "outputC")
)

# Number of repetitions
n_repetitions <- 10

# Number of workers
n_workers <- 2

simulation_settings <- simtracker::initialize_simulation_settings(parameter_settings, n_repetitions)

# Set-up the cluster --------------------------
cl <- simtracker::create_cluster(list_needed_functions_variables = list("simulation_settings"),
                                 num_workers = n_workers)

# add all libraries that are needed
parallel::clusterEvalQ(cl, {
  library(MASS)     # NO COMMA after library()!!!
  library(tidyverse) # a seccond package
  }
)

run_simulation_study(cl, function(parameters) parameters$job.id)

simtracker::stop_cluster(cl)

# Delete the entire simulation --------------------
# simtracker::reset_simulation()
