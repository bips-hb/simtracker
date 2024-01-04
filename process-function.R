# NOTE: This script is purely an example. It returns the forest itself for a single simulation run.
# Normally, the function here processes the result and performs additional tasks (e.g., determining performance, etc).
# NOTE: the function should be called 'process_fn'
process_fn <- function(simulation_result) {
  # In a real scenario, additional processing would be done here
  # For this example, it simply returns the forest obtained from the simulation
  return(simulation_result$forest)
}

