#' Run a simulation study using parallel processing.
#'
#' This function checks the progress of a simulation study, applies a specified
#' function to unfinished runs, and stores the results. It utilizes parallel
#' processing with a provided cluster.
#'
#' @param cluster A parallel cluster object created using functions from the
#' parallel package, e.g., makeCluster.
#'
#' @param sim_fn A function that takes a set of simulation parameters as input
#' and returns the simulation results.
#'
#' @return NULL. The function is designed to run simulations and store results
#' without returning any value.
#'
#' @examples
#' # Create a parallel cluster
#' cl <- makeCluster(2)
#'
#' # Define a simulation function
#' sim_function <- function(parameters) {
#'   # Your simulation logic goes here
#'   # ...
#'   return(simulation_results)
#' }
#'
#' # Run the simulation study
#' run_simulation_study(cl, sim_function)
#'
#' # Close the parallel cluster when done
#' stopCluster(cl)
#'
#' @export
run_simulation_study <- function(cluster, sim_fn) {

  # Check if the file exists
  if (!file.exists("simulations/simulation-settings.rds")) {
    stop("The simulation settings file does not exist. Simulation stopped.")
  }

  log_this("Start or restart of the simulation")

  # Read in the RDS file and check the current status
  simulation_settings <- simtracker::check_progress()

  # check how many runs are done
  n_ran <- sum(simulation_settings$ran)
  n_runs <- nrow(simulation_settings)
  percentage <- n_ran / n_runs * 100
  message <- sprintf("Checked the progress. Currently %d out of %d (%g%%) runs are done",
                     n_ran,
                     n_runs,
                     percentage)
  cat(message,'\n')
  simtracker::log_this(message)

  # Check if there are any runs left
  if (percentage == 100) {
    warning("All simulation settings have already been run. No further action needed.")
    return(NULL)
  }

  simulation_settings <- simulation_settings %>% filter(!ran)

  # Apply the specified function to each row that still needs to run
  parLapply(cl = cluster, 1:nrow(simulation_settings), function(i){

    # get the parameters
    parameters <- simulation_settings[i,]

    log_this(sprintf("Starting job:  %d", i))

    # apply a function to the parameter settings
    result <- sim_fn(parameters)

    log_this(sprintf("Done with job: %d", i))

    results_filename <- paste0("simulations/results/", parameters$filename)
    log_this(sprintf("Storing results for job %d in the file %s", i, parameters$filename))
    readr::write_rds(result, results_filename)

    return(NULL)
  })

  simtracker::check_progress()

  message <- "SIMULATION STUDY DONE. All results are in the simulations/results/ folder"
  log_this(message)
  cat(message, '\n')
}
