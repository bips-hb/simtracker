#' Initialize Simulation Settings
#'
#' Creates simulation parameter settings by repeating a tibble with specified parameters.
#'
#' @param input_tibble A tibble containing parameter settings.
#' @param repetitions Number of times to repeat the tibble.
#'
#' @return A new tibble with repeated rows and additional columns for tracking simulation parameters.
#'
#' @details
#' This function initializes simulation settings by repeating a tibble of parameter settings a specified
#' number of times. It adds columns for replication index, whether it has been run, whether it should be ignored,
#' random seed, job ID, and a unique filename for each row. Before proceeding, it checks if the 'simulations'
#' directory exists. If not, it stops and displays an error message. It also checks if the 'simulation-settings.rds'
#' file already exists. If it does, the function stops and displays an error message.
#'
#' @examples
#' \dontrun{
#' # Assuming 'my_tibble' is your tibble with parameter settings
#' sim_settings <- initialize_simulation_settings(my_tibble, repetitions = 3)
#' }
#'
#' @import dplyr
#' @export
initialize_simulation_settings <- function(input_tibble, repetitions) {
  # Check if the 'simulations' directory exists
  if (!dir.exists("simulations")) {
    stop("Error: The 'simulations' directory does not exist. Cannot proceed.")
  }

  # Check if the 'simulation-settings.rds' file exists
  if (file.exists("simulations/simulation-settings.rds")) {
    stop("Error: The 'simulation-settings.rds' file already exists. Cannot proceed.")
  }

  if (!inherits(input_tibble, "data.frame")) {
    stop("Input must be a tibble or data.frame.")
  }

  # Repeat the tibble using dplyr::bind_rows
  result_tibble <- dplyr::bind_rows(replicate(repetitions, input_tibble, simplify = FALSE))

  # Add replication index
  result_tibble$replication <- rep(1:repetitions, each = nrow(input_tibble))

  # Add whether it has been run
  result_tibble$ran <- FALSE

  # Add whether it should be ignored
  result_tibble$ignore <- FALSE

  # Add random seed
  result_tibble$seed <- 1:nrow(result_tibble)

  # Add job ID
  result_tibble$job.id <- 1:nrow(result_tibble)

  # Create unique filename
  result_tibble$filename <- apply(result_tibble, 1,
                                  simtracker::create_unique_file_name_from_row)

  simtracker::create_unique_file_name_from_row(result_tibble[1,])

  # Store the result_tibble in 'simulation-settings.rds'
  saveRDS(result_tibble, file = "simulations/simulation-settings.rds")

  return(result_tibble)
}

# Example usage
# \dontrun{
# # Assuming 'my_tibble' is your tibble with parameter settings
# sim_settings <- initialize_simulation_settings(my_tibble, repetitions = 3)
# }
