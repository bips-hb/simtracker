#' Create a directory if it does not exist already
#'
#' This function checks if a specified directory exists. If the directory does
#' not exist, it creates the directory along with any necessary parent
#' directories.
#'
#' @param directory_path Character string specifying the path of the directory to create.
#'
#' @return Invisible NULL. The function is called for its side effect of creating a directory.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' create_directory_if_not_exists("path/to/your/directory")
#' }
#'
#' @export
create_directory_if_not_exists <- function(directory_path) {
  # Check if the directory already exists
  if (!dir.exists(directory_path)) {
    # If not, create the directory
    dir.create(directory_path, recursive = TRUE)
    cat("Directory created:", directory_path, "\n")
  } else {
    cat("Directory already exists:", directory_path, "\n")
  }
  invisible(NULL)  # Return invisible NULL for side effect
}
