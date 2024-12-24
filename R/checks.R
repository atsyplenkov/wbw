# Check is package installed
check_package <-
  function(package) {
    if (!requireNamespace(package, quietly = TRUE)) {
      stop(paste(package, "is required but not installed."))
    }
  }

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
        extension = c(".tif", ".tiff")
      )
    }
  }

check_input_raster <-
  function(raster_obj) {
    checkmate::assert_class(
      raster_obj,
      classes = c(
        "python.builtin.Raster",
        "python.builtin.object"
      )
    )
  }

# helper function to skip tests if we don't have the 'foo' module
skip_if_no_wbw <- function() {
  have_wbw <- reticulate::py_module_available("whitebox_workflows")
  if (!have_wbw) {
    testthat::skip("WbW is not available for testing")
  }
}