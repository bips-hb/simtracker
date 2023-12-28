#' Create and Export Cluster for Parallel Computation
#'
#' This function creates a parallel cluster, exports necessary functions and data,
#' and returns the created cluster for parallel computations.
#'
#' @param list_needed_functions_variables List with all the functions and
#'              variables that are needed by each process (default is an empty list)
#' @param num_workers The number of workers in the cluster (default is 2).
#'
#' @return A parallel cluster object.
#'
#' @examples
#' \dontrun{
#' # Example usage:
#' cluster <- create_and_export_cluster(num_workers = 2)
#' # Perform parallel computations using the created cluster
#' stopCluster(cluster)  # Don't forget to stop the cluster when done
#' }
#'
#' @export
create_cluster <- function(list_needed_functions_variables = list(),
                                      num_workers = 2) {

  if (num_workers > 50) {
    stop("The workstation cannot handle more than 50 workers. Please choose a smaller number.")
  }

  # Create cluster
  cl <- parallel::makeCluster(num_workers, type = "PSOCK")

  # Export own functions, data, variables to the cluster
  parallel::clusterExport(cl,
                list_needed_functions_variables)

  return(cl)
}
