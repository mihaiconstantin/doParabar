# doParabar 1.0.0

## Added
- Add implementation for the `%dopar%`
  [`foreach`](https://CRAN.R-project.org/package=foreach) operator via function
  `doParabar::doPar`.
- Add `getNumberOfWorkers` helper to get the number of cores for the currently
  registered backend.
- Add `parabarInfo` helper to get the registered `parabar` backend details.
- Add `debugMessage` helper to print debug messages in verbose mode.
- Add `registerDoParabar` function to register the `doPar` implementation for
  the `%dopar%` operator.
- Add package logo and template based on the
  [`parabar`](https://parabar.mihaiconstantin.com) package.
- Add package documentation.
