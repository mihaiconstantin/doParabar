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
#' Registered Implementation Information
#'
#' @description
#' This function is used internally by [`foreach::foreach`] to retrieve
#' information about the registered [`foreach::%dopar%`] operator
#' implementation. More specifically, this function is called by
#' [foreach::getDoParName()], [foreach::getDoParRegistered()],
#' [foreach::getDoParVersion()], and [foreach::getDoParWorkers()].
#'
#' @param data An object of class [`parabar::Backend`] representing the backend
#' used for the [`foreach::%dopar%`] operator implementation.
#'
#' @param item A character string specifying the information item to be
#' retrieved about the registered [`foreach::%dopar%`] operator implementation.
#'
#' @return The requested information item.
#'
#' @keywords internal
parabarInfo <- function(data, item) {
    switch(item,
        # Get the number of backend workers.
        workers = getNumberOfWorkers(data),

        # Provide a name for the registered implementation.
        name = paste0("doParabar (", parabar::Helper$get_class_name(data), ")"),

        # Get the package version.
        version = utils::packageDescription("doParabar", fields = "Version"),

        # For any other informational items return `NULL`.
        NULL
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
