<p align="center">
    <a href="https://parabar.mihaiconstantin.com">
        <img width="180px" src="man/figures/logo.png" alt="parabar logo"/>
    </a>
</p>

<h1 align="center">
    Parallel Adaptor
    <br>
    <sub><code style="display:inline">foreach</code> &#x1F50C; <code style="display:inline">parabar</code></sub>
</h1>

<!-- badges: start -->
<p align="center">
    <a href="https://www.repostatus.org/#active"><img src="https://www.repostatus.org/badges/latest/active.svg" alt="Repository status"/></a>
    <a href="https://github.com/mihaiconstantin/doParabar/releases"><img src="https://img.shields.io/github/v/release/mihaiconstantin/doParabar?display_name=tag&sort=semver" alt="GitHub version"/></a>
    <a href="https://cran.r-project.org/package=doParabar "><img src="https://www.r-pkg.org/badges/version/doParabar" alt="CRAN version"/></a>
    <a href="https://www.r-pkg.org/pkg/doParabar"><img src="https://cranlogs.r-pkg.org/badges/grand-total/doParabar" alt="CRAN RStudio mirror downloads"/></a>
    <a href="https://github.com/mihaiconstantin/doParabar/actions"><img src="https://github.com/mihaiconstantin/doParabar/workflows/R-CMD-check/badge.svg" alt="R-CMD-check" /></a>
    <a href="https://cran.r-project.org/web/checks/check_results_doParabar.html"><img src="https://badges.cranchecks.info/worst/doParabar.svg" alt="CRAN checks"/></a>
    <a href="https://parabar.mihaiconstantin.com"><img src="https://img.shields.io/badge/docs-website-brightgreen" alt="Documentation website"/></a>
</p>
<!-- badges: end -->

The `doParabar` package acts as a
[`foreach`](https://CRAN.R-project.org/package=foreach) parallel adaptor for
[`parabar`](https://parabar.mihaiconstantin.com) backends. It provides a minimal
implementation for the `foreach::%dopar%` operator, enabling seamless
integration of the [`parabar`](https://parabar.mihaiconstantin.com) package with
the [`foreach`](https://CRAN.R-project.org/package=foreach)  package.

## Installation

You can install `doParabar` directly from `CRAN` using the following command:

```r
# Install the package from `CRAN`.
install.packages("doParabar")

# Load the package.
library(doParabar)
```

Alternatively, you can also install the latest development version from `GitHub`
via:

```r
# Install the package from `GitHub`.
remotes::install_github("mihaiconstantin/doParabar")

# Load the package.
library(doParabar)
```

## Usage

Below you can find a minimal example of how to use `doParabar` and
[`parabar`](https://parabar.mihaiconstantin.com) packages in your `R` scripts.
All examples below assume that you have already installed and loaded the
packages.

```r
# Load packages.
library(parabar)
library(doParabar)

# Start an asynchronous `parabar` backend as usual.
backend <- parabar::start_backend(cores = 4, "psock", "async")

# Register the backend with the `foreach` package.
doParabar::registerDoParabar(backend)

# Use the `foreach` package as usual.
results <- foreach(i = 1:1000, .combine = c) %dopar% {
    # Sleep a bit.
    Sys.sleep(0.01)

    # Compute and return.
    i + 1
}

# Stop the backend.
parabar::stop_backend(backend)
```

**_Note._** The `doParabar` package provides only a minimal implementation for
the `foreach::%dopar%` operator. If you need additional functionality, please
consider contributing to the package, or opening an issue on `GitHub`.

## Contributing
- Any contributions are welcome and greatly appreciated. Please open a [pull
  request](https://github.com/mihaiconstantin/doParabar/pulls) on `GitHub`.
- To report bugs, or request new features, please open an
  [issue](https://github.com/mihaiconstantin/doParabar/issues) on `GitHub`.

## License
- The package source code in this repository is licensed under the [MIT
  license](https://opensource.org/license/mit).
- <p class="license-cc" xmlns:cc="https://creativecommons.org/ns#" xmlns:dct="https://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://parabar.mihaiconstantin.com">The <code>parabar</code> and <code>doParabar</code> documentation, vignettes, and other website materials</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://mihaiconstantin.com">Mihai Constantin</a> are licensed under <a href="https://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY 4.0 <img style="height:22px!important" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"> <img style="height:22px!important" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a>.</p>