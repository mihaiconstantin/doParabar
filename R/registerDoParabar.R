registerDoParabar <- function(backend) {
    # Register the `%dopar%` operator implementation.
    foreach::setDoPar(
        # The implementation.
        fun = doParabar,

        # Information to be passed to the registered implementation.
        data = backend,

        # Information about the implementation.
        info = parabarInfo
    )
}
