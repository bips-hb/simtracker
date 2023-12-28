#' Create Unique File Name from Tibble Row
#'
#' This function creates a unique file name from a row in a tibble by concatenating
#' all values in the row and appending the extension ".rds".
#'
#' @param tibble_row A single row of a tibble.
#'
#' @return A character string representing a unique file name with the ".rds" extension.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' tibble_row <- tibble(param1 = "abc", param2 = 123, result = "output")
#' file_name <- create_unique_file_name_from_row(tibble_row)
#' }
#'
#' @export
create_unique_file_name_from_row <- function(tibble_row) {
  # Convert row values to a character vector
  row_values <- as.character(unlist(tibble_row))

  # Concatenate values into a single string
  file_name <- paste0(row_values, collapse = "_")

  # Append ".rds" to the file name
  file_name <- paste0(file_name, ".rds")

  return(file_name)
}

# Example usage:
# tibble_row <- tibble(param1 = "abc", param2 = 123, result = "output")
# file_name <- create_unique_file_name_from_row(tibble_row)
# print(file_name)
