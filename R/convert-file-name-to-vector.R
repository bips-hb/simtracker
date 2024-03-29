#' Convert File Name to Vector
#'
#' This function takes a file name generated by create_unique_file_name_from_row
#' and converts it into a vector with an arbitrary number of elements.
#'
#' @param file_name A character string representing a file name with the ".rds" extension.
#'
#' @return A character vector.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' file_name <- "abc_123_output.rds"
#' vector <- convert_file_name_to_vector(file_name)
#' }
#'
#' @export
convert_file_name_to_vector <- function(file_name) {
  # Remove ".rds" extension
  file_name <- sub("\\.rds$", "", file_name)

  # Split file name into values
  values <- unlist(strsplit(file_name, "_"))

  return(values)
}
