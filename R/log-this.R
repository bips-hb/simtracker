#' Log This
#'
#' This function appends one or multiple lines to the log file.
#'
#' @param ... One or more character strings representing the lines to be logged.
#'
#' @return None (invisibly returns NULL).
#'
#' @examples
#' log_this("Simulation started at", Sys.time())
#' log_this("Simulation in progress...")
#' log_this("Simulation completed at", Sys.time())
#'
#' @export
log_this <- function(...) {

  # Check if the file exists
  if (!file.exists("simulations/log.txt")) {
    stop(paste("Error: The log file does not exist."))
  }

  # Open the file for appending
  file_conn <- file("simulations/log.txt", open = "a")

  # Capture the lines to be logged
  lines_to_log <- paste(..., collapse = "\n")

  # Write lines to the file
  cat(lines_to_log, "\n", file = file_conn)

  # Close the file connection
  close(file_conn)
  invisible(NULL)
}
