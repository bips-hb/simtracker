#' Process Simulation Results
#'
#' This function retrieves simulation settings using simtracker::check_progress.
#' Any simulations that have not run yet (checked by the 'ran' field being TRUE) are ignored,
#' and the user is informed by a warning. The specified function is applied to each row
#' of the simulation_settings tibble.
#'
#' @param cluster A parallel cluster object created using functions from the
#'                parallel package, e.g., \code{simtracker::create_cluster}.
#'                If \code{cluster = NULL}, the function is run sequentially.
#' @param process_function A function to be applied to each row of simulation_settings.
#'
#' @return NULL
#'
#' @examples
#' \dontrun{
#' # Example of using process_results_simulation with a custom process function
#' process_results_simulation(my_custom_process_function)
#' }
#'
#' @export
process_results_simulation <- function(cluster = NULL, process_function) {
  # Get simulation settings using simtracker::check_progress
  simulation_settings <- simtracker::check_progress()

  # Check if there are no simulations done
  if (sum(simulation_settings$ran) == 0) {
    # If zero, stop the function with a warning
    stop("No simulation settings available. No simulations have run.")
  }

  # Check if there are simulations that have not run yet
  if (!all(simulation_settings$ran)) {
    # If not, issue a warning
    warning("Not all simulations have completed. Ignoring incomplete results.")
  }

  log_this("Processing results...")

  # Get only the settings for which the results are in
  simulation_settings <- simulation_settings %>% filter(ran)

  # Apply the specified function to each row that still needs to run ------

  if (is.null(cluster)) { # run the code sequentially

    results <- lapply(1:nrow(simulation_settings), function(i) {
      log_this(sprintf("Processing results of run %d", i))

      # Get the parameters
      parameters <- simulation_settings[i, ]

      # Load the results file for that parameter settings
      result <-
        readRDS(paste0('simulations/results/', parameters$filename))

      # Apply the user-specified processing function
      return(process_function(result))
    })

  } else { # run in parallel
    results <-
      parLapply(cl = cluster, 1:nrow(simulation_settings), function(i) {
        log_this(sprintf("Processing results of run %d", i))

        # Get the parameters
        parameters <- simulation_settings[i, ]

        # Load the results file for that parameter settings
        result <-
          readRDS(paste0('simulations/results/', parameters$filename))

        # Apply the user-specified processing function
        return(process_function(result))
      })
  }

  # Save the processed results as an RDS file
  saveRDS(results, file = "simulations/processed-results.rds")

  log_this("DONE Processing results")
  log_this("Results are stored in simulations/processed-results.rds")

  invisible(NULL)
}
