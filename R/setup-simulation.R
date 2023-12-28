#' Setup Simulation
#'
#' This function initializes a simulation by creating a directory for simulations
#' and a subdirectory for results. It also creates a "global.rds" file to store
#' global information about the simulation.
#'
#' @param simulation_name Character string specifying the name of the simulation.
#'
#' @return Invisible NULL.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' setup_simulation("my_simulation")
#' # Run your simulation steps here
#' }
#'
#' @export
setup_simulation <- function(simulation_name) {
  # Check if simulations directory already exists
  simulations_dir <- "simulations"
  if (dir.exists(simulations_dir)) {
    stop("The 'simulations' directory already exists. Only one simulation per repository is allowed.")
  }

  # Create simulations directory
  dir.create(simulations_dir)
  cat("Simulations directory created:", simulations_dir, "\n")

  # Create results directory inside the simulations directory
  results_dir <- file.path(simulations_dir, "results")
  if (!dir.exists(results_dir)) {
    dir.create(results_dir, recursive = TRUE)
    cat("Results directory created:", results_dir, "\n")
  }

  # Create global.rds file and store simulation_name
  global_file <- file.path(simulations_dir, "global.rds")
  global_data <- list(simulation_name = simulation_name)
  saveRDS(global_data, file = global_file)
  cat("Global information stored in:", global_file, "\n")

  # Create the log file
  file.create("simulations/log.txt")

  # Check if the file was successfully created
  if (file.exists("simulations/log.txt")) {
    cat("Log file created successfully\n")
  } else {
    stop("Error: Unable to create the log file.")
  }

  log_this(sprintf("Simulation folder for %s created successfully", simulation_name))

  # Create the .gitignore file with a single character "*"
  cat("*\n!.gitignore", file = "simulations/results/.gitignore")

  invisible(NULL)
}
