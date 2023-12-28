#' Stop Cluster
#'
#' Wraps the stopCluster function to gracefully stop a parallel cluster.
#'
#' @param cl The cluster object to be stopped.
#'
#' @details
#' This function provides a wrapper around the stopCluster function, allowing for
#' the graceful stopping of a parallel cluster. It is useful in scenarios where
#' you want to stop a cluster without encountering errors.
#'
#' @seealso
#' \code{\link[parallel]{stopCluster}}
#'
#' @examples
#' \dontrun{
#' # Assuming 'cl' is your parallel cluster object
#' stop_cluster(cl)
#' }
#'
#' @export
stop_cluster <- function(cl) {
  parallel::stopCluster(cl)
  cat("Parallel cluster stopped successfully.\n")
  simtracker::log_this("Parallel cluster stopped successfully.")
}
