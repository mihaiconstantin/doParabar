#' @title
#' `%dopar%` Implementation For `parabar` Backends
#'
#' @description
#' See the documentation of [`foreach::foreach-ext`] for more information on how
#' to provide an implementation for the [`foreach::%dopar%`] operator.
#'
#' @details
#' Currently, the following [`foreach::foreach`] arguments are supported:
#'
#' |         Argument |  Status   |
#' | ---------------: | :-------: |
#' |            `...` | supported |
#' |       `.combine` | supported |
#' |          `.init` | supported |
#' |         `.final` | supported |
#' |       `.inorder` | supported |
#' |  `.multicombine` | supported |
#' |    `.maxcombine` | supported |
#' | `.errorhandling` | supported |
#' |      `.packages` | supported |
#' |        `.export` | supported |
#' |      `.noexport` | supported |
#' |       `.verbose` | supported |
#'
#' @return A list containing the results of the parallel computation.
#'
#' @keywords internal
doPar <- function(obj, expr, envir, data) {
    # Ensure `obj` is of `foreach` type.
    Helper$check_object_type(obj, "foreach")

    # Rename the `data` to `backend` to be more descriptive.
    backend <- data

    # Create an iterator object from the input object.
    iterator <- iterators::iter(obj)

    # Create an accumulator function for the iterator.
    accumulator <- foreach::makeAccum(iterator)

    # Prepare the items to be processed.
    items <- as.list(iterator)

    # Create an export environment.
    export_env <- new.env(parent = emptyenv())

    # If there are any user exports provided.
    if (!is.null(obj$export)) {
        # Extract the symbols to be exported.
        exports <- obj$export

        # If there are any symbols that should not be exported.
        if (!is.null(obj$noexport)) {
            # Remove the symbols that should not be exported.
            exports <- setdiff(obj$export, obj$noexport)
        }

        # If there is at least one symbol to export.
        if (length(exports) > 0) {
            # Assign each object to be exported.
            for (symbol in exports) {
                # Get the symbol value from the calling environment or enclosing frames.
                value <- tryCatch(
                    # Attempt.
                    expr = {
                        # Get the value.
                        get(symbol, envir = envir, inherits = TRUE)
                    },

                    # Catch.
                    error = function(e) {
                        # Throw.
                        stop(
                            paste0("Symbol `", symbol, "` provided via `.export` not found."),
                            call. = FALSE
                        )
                    }
                )

                # Assign the value to the export environment.
                assign(symbol, value, envir = export_env)
            }
        }
    }

    # Assign the list of packages to be loaded on the cluster.
    assign("packages", obj$packages, envir = export_env)

    # Export objects to the cluster.
    parabar::export(
        # Where to export.
        backend = backend,

        # What to export.
        variables = ls(export_env),

        # From where to export.
        environment = export_env
    )

    # If there are any packages provided.
    if (!is.null(export_env$packages)) {
        # Load the packages.
        parabar::evaluate(backend, {
            # Load each package.
            lapply(packages, library, character.only = TRUE)
        })
    }

    # Define the task to be evaluated for each item.
    task <- function(arguments) {
        # Evaluate the task cautiously.
        tryCatch(
            # Attempt.
            expr = {
                # Evaluate the task for the current item.
                eval(expr, envir = arguments)
            },

            # Catch.
            error = function(e) {
                # Return the exception as is.
                e
            }
        )
    }

    # Apply the task function to each item using `parabar::par_lapply`.
    results <- parabar::par_lapply(backend, items, task)

    # Try to accumulate the results.
    tryCatch(
        # Attempt.
        expr = {
            accumulator(results, seq_along(results))
        },
        # Catch.
        error = function(e) {
            # Print the feedback message.
            warning(
                paste0("Error calling the `.combine` function provided: ", e$message, "."),
                call. = FALSE
            )
        }
    )

    # Check for any errors.
    error_value <- foreach::getErrorValue(iterator)
    error_index <- foreach::getErrorIndex(iterator)

    # If the user indicated `stop` on error and an error occurred.
    if (obj$errorHandling == "stop" && !is.null(error_value)) {
        # Throw.
        stop(
            paste0("Task ", error_index, " failed: ", conditionMessage(error_value)),
            call. = FALSE
        )
    }

    # Otherwise get and return the results.
    return(foreach::getResult(iterator))
}
