#' Install Required Python Modules
#' @keywords system
#'
#' This function installs the latest \code{numpy}, \code{whitebox-workflows}.
#' The default uses \code{pip} for package installation.
#'
#' @param system \code{boolean}, Use a \code{system()} call to
#' \code{python -m pip install --user ...}
#' instead of \code{reticulate::py_install()}. Default: \code{FALSE}.
#' @param force \code{boolean}, Force update (uninstall/reinstall) and ignore
#' existing installed packages? Default: \code{FALSE}.
#' Applies to \code{system=TRUE}.
#' @param ... Additional arguments passed to `reticulate::py_install()`
#'
#' @details This function provides a basic wrapper around
#'  `reticulate::py_install()`, except it defaults to using the Python package
#' manager \code{pip} and virtual environment. It creates the \code{r-wbw} virtual
#' environment in the default location (run `reticulate::virtualenv_root()` to
#' find it) and installs the required python packages.
#'
#' @return `NULL`, or `try-error` (invisibly) on R code execution error.
#'
#' @export
wbw_install <-
  function(system = FALSE, force = FALSE, ...) {
    args <- list(...)

    venv_name <- "r-wbw"
    venv_exists <-
      try(
        reticulate::virtualenv_exists(venv_name),
        silent = TRUE
      )

    # Check if venv exists
    if (venv_exists && !system) {
      # Check if `whitebox-workflows` is installed
      reticulate::use_virtualenv(venv_name)
      wbw_version <- wbw_version()
    }

    # Install `whitebox-workflows`
    if (venv_exists && is.null(wbw_version) && !system) {
      # venv exists but whitebox is not installed
      # install it from https://pypi.org/project/whitebox-workflows/
      reticulate::use_virtualenv(virtualenv = venv_name)
      reticulate::virtualenv_install(
        packages = c("numpy", "whitebox-workflows==1.3.3"),
        envname = venv_name
      )
      .success_message(wbw_version())
    } else if (!venv_exists && !system) {
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
      cli::cli_alert_info(
        c(
          "Please, restart you R session"
        )
      )
    } else if (venv_exists && !is.null(wbw_version) && !system) {
      .success_message(wbw_version())
    }

    if (system) {
      fp <- .find_python()
      if (nchar(fp) > 0) {
        return(invisible(system(
          paste(
            shQuote(fp),
            "-m pip install --user",
            ifelse(force, "-U --force", ""),
            "whitebox-workflows==1.3.3 numpy"
          )
        )))
      }
    }
  }

.success_message <- function(wbw_version) {
  cli::cli_alert_success(
    c(
      "You're all set! The Python library {.code whitebox-workflows} ",
      "v{wbw_version} has been found!"
    )
  )
}
