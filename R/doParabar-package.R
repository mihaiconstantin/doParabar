# # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                              _                      #
#  do                         | |                     #
#   _ __    __ _  _ __   __ _ | |__    __ _  _ __     #
#  | '_ \  / _` || '__| / _` || '_ \  / _` || '__|    #
#  | |_) || (_| || |   | (_| || |_) || (_| || |       #
#  | .__/  \____||_|    \____||____/  \____||_|       #
#  | |                                                #
#  |_|                                                #
#                                                     #
# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Author: Mihai A. Constantin                         #
# Documentation: https://parabar.mihaiconstantin.com  #
# Contact: mihai@mihaiconstantin.com                  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # #


# Imports.
#' @importFrom parabar Helper export evaluate par_lapply
#' @importFrom foreach setDoPar getResult makeAccum getErrorValue getErrorIndex
#' @importFrom iterators iter
#' @importFrom utils packageDescription


#' @title Foreach Parallel Adaptor For `parabar` Backends
#'
#' @details
#' The [`doParabar::doParabar`] package acts as a [`foreach::foreach`] parallel
#' adaptor for [`parabar::parabar`] backends. It provides a minimal
#' implementation for the [`foreach::%dopar%`] operator, enabling seamless
#' integration of the [`parabar::parabar`] package with the [`foreach::foreach`]
#' package.
#'
#' @section Package Loading:
#' By default, and for various reasons, the [`doParabar::doParabar`] package
#' does not automatically load other packages. Instead, I recommended to load
#' the [`foreach::foreach`] and [`parabar::parabar`] packages explicitly in your
#' scripts (i.e., or add them to your `Imports` in the `DESCRIPTION` file when
#' developing an `R` package). Package startup messages can be suppressed via
#' [base::suppressPackageStartupMessages()].
#'
#' @section Automatic Exporting:
#' Note that [`doParabar::doParabar`] does not automatically export variables to
#' the backend. Instead, I strongly recommend being explicit about what you want
#' to export to the backend and use the `.export` and `.noexport` arguments.
#' Similarly, the `.packages` argument can be used to indicate which packages
#' should be loaded on the backend. Please check the **Details** section of the
#' documentation for [`doParabar::doPar()`] for all supported arguments.
#'
#' @section Resources:
#' - For more information about [`parabar::parabar`], please consult de
#' documentation and examples at
#' [parabar.mihaiconstantin.com](https://parabar.mihaiconstantin.com).
#' - For specific information about using [`parabar::parabar`] in conjunction
#' with [`foreach::foreach`] please check the online vignette at
#' [parabar.mihaiconstantin.com/articles/foreach](https://parabar.mihaiconstantin.com/articles/foreach).
#'
#' @keywords internal
"_PACKAGE"


# Register globals to avoid false positives in `CRAN` checks.
utils::globalVariables(c("packages", "cluster"))


# On package attach.
.onAttach <- function(libname, pkgname) {
    # If there this is an interactive session.
    if (interactive()) {
        # Print package information.
        packageStartupMessage(LOGO)
    }
}
