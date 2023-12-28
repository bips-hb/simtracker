#' Modify RDS File
#'
#' This function allows adding, removing, or changing items in an existing RDS file.
#'
#' @param rds_file Character string specifying the path to the existing RDS file.
#' @param action Character string specifying the action to perform ("add", "remove", or "change").
#' @param item_name Character string specifying the name of the item to add, remove, or change.
#' @param new_value The new value to add or change (ignored for "remove" action).
#'
#' @return Invisible NULL.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' # Add a new item
#' modify_rds_file("existing_file.rds", action = "add", item_name = "new_item", new_value = c(1, 2, 3))
#'
#' # Remove an item
#' modify_rds_file("existing_file.rds", action = "remove", item_name = "item_to_remove")
#'
#' # Change the value of an item
#' modify_rds_file("existing_file.rds", action = "change", item_name = "existing_item", new_value = "new_value")
#' }
#'
#' @export
modify_rds_file <- function(rds_file, action, item_name, new_value = NULL) {
  # Read existing content from the RDS file
  existing_content <- readRDS(rds_file)

  # Perform the specified action
  if (action == "add") {
    # Add a new item
    existing_content[[item_name]] <- new_value
  } else if (action == "remove") {
    # Remove an item
    existing_content[[item_name]] <- NULL
  } else if (action == "change") {
    # Change the value of an item
    existing_content[[item_name]] <- new_value
  } else {
    stop("Invalid action. Use 'add', 'remove', or 'change'.")
  }

  # Save the updated content back to the RDS file
  saveRDS(existing_content, file = rds_file)

  invisible(NULL)
}
