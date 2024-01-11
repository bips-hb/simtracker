#' Load Simulation Settings from File
#'
#' This function checks whether the file simulations/simulation-settings.rds exists.
#' If the file exists, it loads and returns its content. Otherwise, it returns an error.
#'
#' @return A list containing the simulation settings.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' settings <- load_simulation_settings()
#' }
#'
#' @export
load_simulation_settings <- function() {
  settings_file <- "simulations/simulation-settings.rds"

  # Check if the file exists
  if (!file.exists(settings_file)) {
    stop("Simulation settings file not found. Please make sure simulations/simulation-settings.rds exists.")
  }

  # Load and return the content of the file
  settings <- readRDS(settings_file)
  return(settings)
}
