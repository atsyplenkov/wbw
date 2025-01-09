#' Check if package is installed
#' @rdname checks
#' @keywords internal
check_package <-
  function(package) {
    if (!requireNamespace(package, quietly = TRUE)) {
      stop(paste(package, "is required but not installed."))
    }
  }

#' Check if whitebox environment is present
#' @rdname checks
#' @keywords internal
check_env <-
  function(env = wbe) {
    checkmate::assert_class(
      env,
      classes = c(
        "whitebox_workflows.WbEnvironment",
        "python.builtin.WbEnvironmentBase",
        "python.builtin.object"
      )
    )
  }

#' Check input file extension
#' @rdname checks
#' @keywords internal
check_input_file <-
  function(file_name, type) {
    type <- checkmate::matchArg(type, c("vector", "raster"))

    if (type == "vector") {
      checkmate::assertFileExists(
        file_name,
        access = "r",
        extension = c(".shp")
      )
    } else if (type == "raster") {
      checkmate::assertFileExists(
        file_name,
        access = "r",
        extension = c(
          ".tif", ".tiff", ".sdat", ".sgrd", ".rst",
          ".rdc", ".grd", ".flt", ".bil"
        )
      )
    }
  }


