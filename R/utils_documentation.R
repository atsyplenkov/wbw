#' Create reference tags for docs
#'
#' @description
#' Links to the Whitebox Workflows for Python manual
#'
#' @keywords internal
rd_wbw_link <-
  function(fun_name) {
    paste0(
      "@references For more information, see ",
      "<https://www.whiteboxgeo.com/manual",
      "/wbw-user-manual/book/tool_help.html#",
      fun_name,
      ">"
    )
  }

#' Create input parameter tag
#'
#' @description
#' Description of input [WhiteboxRaster] object
#'
#' @keywords internal
rd_input_raster <-
  function(param) {
    paste0(
      "@param ", param,
      " Raster object of class [WhiteboxRaster]. ",
      "See [wbw_read_raster()] for more details."
    )
  }

#' Create basic example
#'
#' @keywords internal
rd_example_geomorph <-
  function(foo, args = NULL) {
    paste(
      "@examples",
      "\\dontrun{",
      'raster_path <- system.file("extdata/dem.tif", package = "wbw")',
      "wbw_read_raster(raster_path) |>",
      ifelse(
        is.null(args),
        paste0("  ", foo, "()"),
        paste0(
          "  ", foo, "(",
          paste(args, collapse = ", "), ")"
        )
      ),
      "}",
      sep = "\n"
    )
  }