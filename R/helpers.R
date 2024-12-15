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
