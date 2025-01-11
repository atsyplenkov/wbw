# Used https://github.com/brownag/rgeedim/blob/main/R/AAAA.R and
# https://github.com/JosiahParry/pyfns as an examples.
# Thanks guys!

wbw <- NULL
wbe <- NULL

#' `wbw_version()`: Gets the `Whitebox Workflows` version
#' @return character. Version Number.
#' @export
#' @importFrom reticulate py_eval
wbw_version <- function() {
  try(
    reticulate::py_run_string("from importlib.metadata import version"),
    silent = TRUE
  )
  version <- try(
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
        wbw <<- reticulate::import(
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

.has_wbw <- function() {
  if (reticulate::virtualenv_exists("r-wbw")) {
    reticulate::use_virtualenv("r-wbw")
    have_wbw <- reticulate::py_module_available("whitebox_workflows")
    have_numpy <- reticulate::py_module_available("numpy")
  } else {
    have_wbw <- reticulate::py_module_available("whitebox_workflows")
    have_numpy <- reticulate::py_module_available("numpy")
  }

  all(have_wbw, have_numpy)
}

#' @importFrom reticulate configure_environment
#' @importFrom cli cli_alert_info cli_alert_success cli_alert_warning
#' @importFrom utils menu
.onLoad <- function(libname, pkgname) {
  S7::methods_register()

  if (.has_python3() && !.has_wbw()) {
    if (interactive()) {
      cli::cli_alert_warning(
        "Library {.code whitebox-workflows} is required but not found."
      )
      choice <- utils::menu(
        c(
          "Install dependencies in a virtual environment (recommended)",
          "Install dependencies system-wide",
          "Do nothing"
        )
      )

      if (choice == 1) {
        cli::cli_alert_info(
          "Installing dependencies in virtual environment..."
        )
        i <- try(wbw_install(), silent = TRUE)
        if (!inherits(i, "try-error")) {
          cli::cli_alert_success(
            c(
              "All done! Please, restart you R session"
            )
          )
        } else {
          cli::cli_alert_danger(
            c(
              "Oups, something went wrong :-(\n",
              "Please try to install dependencies manually by running ",
              "{.run wbw::wbw_install()}"
            )
          )
        }
      } else if (choice == 2) {
        cli::cli_alert_info(
          "Installing dependencies system-wide..."
        )
        i <- try(wbw_install(system = TRUE), silent = TRUE)
        if (!inherits(i, "try-error")) {
          cli::cli_alert_success(
            c(
              "All done!"
            )
          )
        } else {
          cli::cli_alert_danger(
            c(
              "Oups, something went wrong :-(\n",
              "Please try to install dependencies manually by running ",
              "{.run wbw::wbw_install()}"
            )
          )
        }
      }
    } else {
      # Non-interactive: install system-wide
      wbw_install(system = TRUE)
    }
  }

  # Try loading modules after potential installation
  if (.has_python3() && .has_wbw()) {
    if (!.loadModules()) {
      x <- try(reticulate::configure_environment(pkgname), silent = TRUE)
      if (!inherits(x, "try-error")) {
        .loadModules()
      }
    }
  }
}

#' @importFrom utils packageVersion
.onAttach <- function(libname, pkgname) {
  wbwv <- wbw_version()
  suppress <- !grepl(
    "suppressed",
    Sys.getenv("wbw.message"),
    ignore.case = TRUE
  )

  if (is.null(wbwv) && suppress && interactive()) {
    cli::cli_alert_warning(
      c(
        "Python package `whitebox-workflows` cannot be found.",
        "Run {.code wbw::wbw_install()} and reload R session."
      )
    )
  } else if (!is.null(wbwv) && suppress) {
    cli::cli_alert_success(
      c(
        "wbw v{utils::packageVersion('wbw')} -- using whitebox-workflows v{wbwv}"
      )
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
