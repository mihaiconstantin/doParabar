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


# On package load.
.onLoad <- function(libname, pkgname) {
}


# On package attach.
.onAttach <- function(libname, pkgname) {
    # If there this is an interactive session.
    if (interactive()) {
        # Print package information.
        packageStartupMessage(LOGO)
    }
}


# On package unload.
.onUnload <- function(libpath) {
}
