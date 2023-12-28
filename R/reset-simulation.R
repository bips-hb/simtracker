#' Reset Simulation
#'
#' Deletes a fixed folder and its contents after user confirmation.
#'
#' @details
#' This function deletes a fixed folder and its contents. It asks the user for
#' confirmation before proceeding with the deletion.
#'
#' @return
#' Prints a message indicating whether the folder and its contents were
#' successfully deleted or if the deletion was canceled by the user.
#'
#' @examples
#' \dontrun{
#' reset_simulation()
#' }
#'
#' @export
reset_simulation <- function() {
  folder_path <- "simulations/"  # Replace with the actual folder path

  # Check if the folder exists
  if (file.exists(folder_path)) {
    # Ask for user confirmation
    cat(paste("Are you sure you want to delete the folder '", folder_path, "' and its contents? (y/n): "))

    # Read user input
    user_input <- readline(prompt = "")

    # Check user input
    if (tolower(user_input) == "y" | tolower(user_input) == "yes") {
      # Delete the folder and its contents
      unlink(folder_path, recursive = TRUE)
      cat("Folder and its contents deleted successfully.\n")
    } else {
      cat("Deletion canceled by user.\n")
    }
  } else {
    cat("Simulation folder does not exist.\n")
  }
}
