% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/registerDoParabar.R
\name{registerDoParabar}
\alias{registerDoParabar}
\title{Register Parallel Implementation}
\usage{
registerDoParabar(backend)
}
\arguments{
\item{backend}{An object of class \code{\link[parabar:Backend]{parabar::Backend}} representing the
backend to be used for the \code{\link[foreach:foreach]{foreach::\%dopar\%}} operator implementation.}
}
\value{
The \code{\link[=registerDoParabar]{registerDoParabar()}} function returns void.
}
\description{
The \code{\link[=registerDoParabar]{registerDoParabar()}} function registers the provided
\code{\link[parabar:BackendService]{backend}} created by \code{\link[parabar:start_backend]{parabar::start_backend()}}
to be used as the parallel processing backend for the \code{\link[foreach:foreach]{foreach::\%dopar\%}}
operator implementation.
}
\details{
Additional information about the registered parallel backend can be extracted
using the \code{\link[foreach:getDoParWorkers]{foreach::getDoParName()}}, \code{\link[foreach:getDoParWorkers]{foreach::getDoParRegistered()}},
\code{\link[foreach:getDoParWorkers]{foreach::getDoParVersion()}}, and \code{\link[foreach:getDoParWorkers]{foreach::getDoParWorkers()}} functions. See
the \strong{Examples} section.
}
\section{Completeness}{

The parallel backend implementation for the \code{\link[foreach:foreach]{foreach::\%dopar\%}} operator is
provided by the \code{\link[=doPar]{doPar()}} function. Please check the \strong{Details}
section of its documentation to understand the extent of completeness of the
implementation.
}

\examples{
# Manually load the libraries.
library(doParabar)
library(parabar)
library(foreach)

# Create an asynchronous `parabar` backend.
backend <- start_backend(cores = 2, cluster_type = "psock", backend_type = "async")

# Register the backend with the `foreach` package for the `\%dopar\%` operator.
registerDoParabar(backend)

# Get the parallel backend name.
getDoParName()

# Check that the parallel backend has been registered.
getDoParRegistered()

# Get the current version of backend registration.
getDoParVersion()

# Get the number of cores used by the backend.
getDoParWorkers()

# Define some variables strangers to the backend.
x <- 10
y <- 100
z <- "Not to be exported."

# Used the registered backend to run a task in parallel via `foreach`.
results <- foreach(i = 1:300, .export = c("x", "y"), .combine = c) \%dopar\% {
    # Sleep a bit.
    Sys.sleep(0.01)

    # Compute and return.
    i + x + y
}

# Show a few results.
head(results, n = 10)
tail(results, n = 10)

# Verify that the variable `z` was not exported.
try(evaluate(backend, z))

# To make packages available on the backend, see the `.packages` argument.

# Stop the backend.
stop_backend(backend)

}
\seealso{
\code{\link{doParabar}}, \code{\link[=doPar]{doPar()}}, \code{\link[parabar:start_backend]{parabar::start_backend()}}
and \code{\link[parabar:stop_backend]{parabar::stop_backend()}}.
}
