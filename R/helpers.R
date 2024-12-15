#' @title
#' Get the Number of Workers
#'
#' @param backend An object of class [`parabar::Backend`] representing the
#' backend used for the [`foreach::%dopar%`] operator implementation.
#'
#' @return An integer representing the number of workers for the registered
#' backend.
#'
#' @keywords internal
getNumberOfWorkers <- function(backend) {
    # Get the number of workers based on the backend type.
    switch(parabar::Helper$get_class_name(backend),

        # If we are dealing with an asynchronous backend.
        "AsyncBackend" = backend$cluster$run(function() {
            # Get the number of workers.
            length(cluster)
        }),

        # If we are dealing with a synchronous backend.
        "SyncBackend" = length(backend$cluster),

        # Otherwise default to a single worker.
        1
    )
}


#' @title
#' Print Debug Message
#'
#' @description
#' This function is used internally to print debug messages when the verbose
#' mode is enabled.
#'
#' @param message A character string representing the message to be printed.
#'
#' @param verbose A logical value indicating whether the verbose mode is
#' enabled. Defaults to `FALSE`.
#'
#' @return This function returns void.
#'
#' @keywords internal
debugMessage <- function(message, verbose = FALSE) {
    # If verbose mode is enabled.
    if (verbose) {
        # Print the message.
        cat(message, "\n")
    }
}
