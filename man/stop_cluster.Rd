% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stop-cluster.R
\name{stop_cluster}
\alias{stop_cluster}
\title{Stop Cluster}
\usage{
stop_cluster(cl)
}
\arguments{
\item{cl}{The cluster object to be stopped.}
}
\description{
Wraps the stopCluster function to gracefully stop a parallel cluster.
}
\details{
This function provides a wrapper around the stopCluster function, allowing for
the graceful stopping of a parallel cluster. It is useful in scenarios where
you want to stop a cluster without encountering errors.
}
\examples{
\dontrun{
# Assuming 'cl' is your parallel cluster object
stop_cluster(cl)
}

}
\seealso{
\code{\link[parallel]{stopCluster}}
}
