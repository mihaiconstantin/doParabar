#' @include doPar.R helpers.R

#' @title
#' Register Parallel Implementation
#'
#' @param backend An object of class [`parabar::Backend`] representing the
#' backend to be used for the [`foreach::%dopar%`] operator implementation.
#'
#' @description
#' The [doParabar::registerDoParabar()] function registers the provided
#' [`backend`][`parabar::BackendService`] created by [parabar::start_backend()]
#' to be used as the parallel processing backend for the [`foreach::%dopar%`]
#' operator implementation.
#'
#' @details
#' Additional information about the registered parallel backend can be extracted
#' using the [foreach::getDoParName()], [foreach::getDoParRegistered()],
#' [foreach::getDoParVersion()], and [foreach::getDoParWorkers()] functions. See
#' the **Examples** section.
#'
#' @section Completeness:
#' The parallel backend implementation for the [`foreach::%dopar%`] operator is
#' provided by the [doParabar::doPar()] function. Please check the **Details**
#' section of its documentation to understand the extent of completeness of the
#' implementation.
#'
#' @return
#' The [doParabar::registerDoParabar()] function returns void.
#'
#' @examples
#' # Manually load the libraries.
#' library(doParabar)
#' library(parabar)
#' library(foreach)
#'
#' # Create an asynchronous `parabar` backend.
#' backend <- start_backend(cores = 2, cluster_type = "psock", backend_type = "async")
#'
#' # Register the backend with the `foreach` package for the `%dopar%` operator.
#' registerDoParabar(backend)
#'
#' # Get the parallel backend name.
#' getDoParName()
#'
#' # Check that the parallel backend has been registered.
#' getDoParRegistered()
#'
#' # Get the current version of backend registration.
#' getDoParVersion()
#'
#' # Get the number of cores used by the backend.
#' getDoParWorkers()
#'
#' # Define some variables strangers to the backend.
#' x <- 10
#' y <- 100
#' z <- "Not to be exported."
#'
#' # Used the registered backend to run a task in parallel via `foreach`.
#' results <- foreach(i = 1:300, .export = c("x", "y"), .combine = c) %dopar% {
#'     # Sleep a bit.
#'     Sys.sleep(0.01)
#'
#'     # Compute and return.
#'     i + x + y
#' }
#'
#' # Show a few results.
#' head(results, n = 10)
#' tail(results, n = 10)
#'
#' # Verify that the variable `z` was not exported.
#' try(evaluate(backend, z))
#'
#' # To make packages available on the backend, see the `.packages` argument.
#'
#' # Stop the backend.
#' stop_backend(backend)
#'
#' @seealso
#' [`doParabar::doParabar`], [doParabar::doPar()], [parabar::start_backend()]
#' and [parabar::stop_backend()].
#'
#' @export
registerDoParabar <- function(backend) {
    # Register the `%dopar%` operator implementation.
    foreach::setDoPar(
        # The implementation.
        fun = doPar,

        # Information to be passed to the registered implementation.
        data = backend,

        # Information about the implementation.
        info = parabarInfo
    )
}
