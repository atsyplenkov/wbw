#' Template {wbw} roxygen2 documentation
#' @rdname template
#' @keywords internal
#'
#' @description
#' This is a template for generating documentation for new Whitebox Workflows
#' for R functions.
#'
#' First, every function description should start with the
#' function name, identical to the original Whitebox Workflows for Python.
#'
#' Then it should be followed by @rdname and @keywords tags. While the @rdname
#' tag could be omitted in cases where you don't want to merge docs of several
#' functions together, the @keywords tag is essential and should follow the
#' grouping by topic, existing for the Whitebox Workflows for Python/QGIS.
#'
#' After @keywords and @rdname, it is essential to provide @description, which
#' should align with the Whitebox Workflows documentation.
#'
#' There are several documentation helpers that can speed up
#' documentation writing. Use them wisely:
#' - @eval rd_input_raster("x") will generate a @param tag describing the input
#' WhiteboxRaster
#' - @eval rd_wbw_link("tool_name") will create a @reference tag with a web
#' link to the original documentation website
#' - @eval rd_example_geomorph("wbw_ruggedness_index") will generate
#' an @examples tag with a basic workflow inside the \dontrun{} tag.
#'
#' @eval rd_input_raster("dem")
#'
#' @return [WhiteboxRaster] object
#'
#' @eval rd_wbw_link("ruggedness_index")
#' @eval rd_example_geomorph("wbw_ruggedness_index")
wbw_template <-
  S7::new_generic(
    name = "wbw_template",
    dispatch_args = "x",
    fun = function(x, another_arg = NULL) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_template, WhiteboxRaster) <-
  function(x, another_arg = NULL) {
    # Checks
    check_env(wbe)
    # Estimate slope
    out <- wbe$ruggedness_index(input = x@source)
    # Return Raster
    WhiteboxRaster(
      name = paste0("TRI"),
      source = out
    )
  }
