#' Check is package installed
#' @rdname checks
#' @keywords internal
check_package <-
  function(package) {
if (!requireNamespace(package, quietly = TRUE)) {
  stop(paste(package, "is required but not installed."))
}
}

#' Check is whitebox environment is presented
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

#' Skip tests if we don't have the 'wbw' module
#' @rdname checks
#' @keywords internal
skip_if_no_wbw <- function() {
  have_wbw <- reticulate::py_module_available("whitebox_workflows")
  if (!have_wbw) {
    testthat::skip("WbW is not available for testing")
  }
}
