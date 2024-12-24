#' Install Required Python Modules
#'
#' This function installs the latest `numpy`, `whitebox-workflows`.
#' The default uses `pip` for package installation.
#'
#' @param ... Additional arguments passed to `reticulate::py_install()`
#'
#' @details This function provides a basic wrapper around
#'  `reticulate::py_install()`, except it defaults to using the Python package
#' manager `pip` and virtual environment. It creates the `r-wbw` virtual
#' environment in the default location (run `reticulate::virtualenv_root()` to
#' find it) and installs the required python packages.
#'
#' @return `NULL`, or `try-error` (invisibly) on R code execution error.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' wbw_install()
#' }
wbw_install <-
  function(...) {
    args <- list(...)

    venv_name <- "r-wbw"
    venv_exists <-
      try(
        reticulate::virtualenv_exists(venv_name),
        silent = TRUE
      )

    # Check if venv exists
    if (venv_exists) {
      # Check if `whitebox-workflows` is installed
      reticulate::use_virtualenv(venv_name)
      wbw_version <- wbw_version()
    }

    # Install `whitebox-workflows`
    if (venv_exists && is.null(wbw_version)) {
      # venv exists but whitebox is not installed
      # install it from https://pypi.org/project/whitebox-workflows/
      reticulate::use_virtualenv(virtualenv = venv_name)
      reticulate::virtualenv_install(
        packages = c("numpy", "whitebox-workflows==1.3.3"),
        envname = venv_name
      )
      .success_message(wbw_version())
    } else if (!venv_exists) {
      # nothing is installed, create venv and install deps
      # from https://pypi.org/project/whitebox-workflows/
      reticulate::virtualenv_create(
        envname = venv_name,
        version = ">= 3.8"
      )
      reticulate::use_virtualenv(
        virtualenv = venv_name
      )
      reticulate::virtualenv_install(
        packages = c("numpy", "whitebox-workflows==1.3.3"),
        envname = venv_name
      )
      .success_message(wbw_version())
    } else if (venv_exists && !is.null(wbw_version)) {
      .success_message(wbw_version)
    }
  }

.success_message <-
  function(wbw_version) {
    cli::cli_alert_success(
      c(
        "You're all set! ",
        "The Python library {.code whitebox-workflows} ",
        "{.field {wbw_version}} has been found!"
      )
    )
  }
