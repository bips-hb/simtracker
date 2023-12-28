#' Check the Progress of the Simulation Study
#'
#' This function loads the simulation settings from the file
#' 'simulations/simulation-settings.rds', extracts filenames, and checks whether
#' the corresponding parameter settings ran by examining the existence of
#' associated files in the 'simulations/results/' folder. It then updates the
#' column 'ran'.
#'
#' Finally, the updated tibble is written back to the original file.
#'
#' @return The tibble with an updated 'ran' column
#'
#' @examples
#' check_progress()
#'
#' @export
check_progress <- function() {

  # Load the simulation settings
  simulation_settings <- readRDS("simulations/simulation-settings.rds")

  # Extract the filenames from the tibble
  filenames <- simulation_settings$filename

  # Check whether that parameter settings ran by checking whether the file
  # associated with that parameter setting exists in the results folder
  simulation_settings$ran <- sapply(filenames, function(filename) {
    file_path <- file.path("simulations/results/", filename)
    file.exists(file_path)
  })

  # Create a new column in the tibble indicating file existence
  readr::write_rds(simulation_settings, "simulations/simulation-settings.rds")

  return(simulation_settings)
}
