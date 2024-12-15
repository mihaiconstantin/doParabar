# # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                              _                      #
#                             | |                     #
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
#' @importFrom foreach setDoPar getResult makeAccum
#' @importFrom iterators iter
#' @importFrom utils packageDescription


#' @template doParabar
"_PACKAGE"


# On package load.
.onLoad <- function(libname, pkgname) {
}


# On package attach.
.onAttach <- function(libname, pkgname) {
}


# On package unload.
.onUnload <- function(libpath) {
}
