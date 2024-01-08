increase_number_of_repetitions <- function(new_number_repetitions) {

  # Check if the file "simulations/simulation-settings.rds" exists
  if (file.exists("simulations/simulation-settings.rds")) {
    # If it exists, load the simulation settings
    simulation_settings <- readRDS("simulations/simulation-settings.rds")
  } else {
    # If it doesn't exist, display an error message
    stop("Error: 'simulations/simulation-settings.rds' not found. ",
         "Initialize simulation settings using simtracker::initialize_simulation_settings.")
  }

  # Get the current number of repetitions
  current_number_repetitions <- max(simulation_settings$replication)

  # Check if current_number_repetitions is higher or equal to new_number_repetitions
  if (current_number_repetitions >= new_number_repetitions) {
    # If true, display an error message and inform the user
    stop("Error: The current number of repetitions is higher or equal to the new number of repetitions. ",
         "Please provide a new_number_repetitions that is greater than the current_number_repetitions.")
  }

  difference <- new_number_repetitions - current_number_repetitions

  # Get the simulation settings for a single replication
  sim <- simulation_settings %>% filter(replication == 1)

  # Repeat it
  sim <- sim %>% slice(rep(1:n(), each = difference))

}
