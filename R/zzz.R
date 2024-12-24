# Used https://github.com/brownag/rgeedim/blob/main/R/AAAA.R and
# https://github.com/JosiahParry/pyfns as an examples.
# Thanks guys!


wbw <- NULL
wbe <- NULL

#' `wbw_version()`: Gets the `Whitebox Workflows` version
#' @return character. Version Number.
#' @export
#' @importFrom reticulate py_eval
wbw_version <-
  function() {
    try(
      reticulate::py_run_string("from importlib.metadata import version"),
      silent = TRUE
    )
    version <-
      try(
        reticulate::py_eval("version('whitebox_workflows')"),
        silent = TRUE
      )
    if (!inherits(version, "try-error")) {
      version
    }
  }

#' @importFrom reticulate import
#' @importFrom reticulate py_run_string
.loadModules <- function() {
  if (is.null(wbw)) {
    try(
      {
        reticulate::use_virtualenv(virtualenv = "r-wbw")
        wbw <<-
          reticulate::import(
            "whitebox_workflows",
            delay_load = TRUE
          )
      },
      silent = TRUE
    )
  }

  if (is.null(wbe)) {
    try(wbe <<- wbw$WbEnvironment(), silent = TRUE)
  }

  # note: requires Python >= 3.8;
  # but is not essential for functioning of package
  try(
    reticulate::source_python(
      system.file("wbw_helpers.py", package = "wbw"),
      envir = wbw_env
    ),
    silent = TRUE
  )

  !is.null(wbe)
}

#' @importFrom reticulate py_discover_config
.has_python3 <- function() {
  # get reticulate python information
  # NB: reticulate::py_config() calls configure_environment() etc.
  #     .:. use py_discover_config()
  x <- try(reticulate::py_discover_config(), silent = TRUE)

  # need python 3 for reticulate
  # need python 3.8+ for whitebox_workflows
  if (length(x) > 0 && !inherits(x, "try-error")) {
    if (numeric_version(x$version) >= "3.8") {
      return(TRUE)
    } else if (numeric_version(x$version) >= "3.0") {
      return(FALSE)
    }
  }
  FALSE
}

#' @importFrom reticulate configure_environment
.onLoad <- function(libname, pkgname) {
  if (.has_python3()) {
    if (!.loadModules()) {
      x <- try(reticulate::configure_environment(pkgname), silent = TRUE)
      if (!inherits(x, "try-error")) {
        .loadModules()
      }
    }
  }
}


# FIXME:
# Update in accordance with
# https://github.com/ropensci/openalexR/blob/main/R/openalexR-internal.R

#' @importFrom utils packageVersion
.onAttach <- function(libname, pkgname) {
  wbwv <- wbw_version()
  if (is.null(wbwv)) {
    packageStartupMessage(
      cli::cli_alert_warning(c(
        "Python package `whitebox-workflows` cannot be found. ",
        "Run {.code wbw::install_wbw()} and reload R session."
      ))
    )
  } else {
    packageStartupMessage(
      cli::cli_alert_success(c(
        "wbw v{utils::packageVersion('wbw')}",
        " -- using whitebox-workflows v{wbwv}"
      ))
    )
  }
}

.find_python <- function() {
  # find python
  py_path <- Sys.which("python")
  if (nchar(py_path) == 0) {
    py_path <- Sys.which("python3")
  }
  py_path
}
