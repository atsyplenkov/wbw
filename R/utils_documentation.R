#' Create reference tags for docs
#'
#' @description
#' Links to the Whitebox Workflows for Python manual
#'
#' @keywords internal
rd_wbw_link <- function(fun_name) {
  checkmate::assert_character(fun_name, min.chars = 1L)
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
rd_input_raster <- function(param) {
  checkmate::assert_character(param, min.chars = 1L)
  paste0(
    "@param ",
    param,
    " Raster object of class [WhiteboxRaster]. ",
    "See [wbw_read_raster()] for more details."
  )
}

#' Create basic example
#'
#' @keywords internal
rd_example <- function(foo, args = NULL) {
  checkmate::assert_character(foo, min.chars = 1L)
  checkmate::assert_vector(args, null.ok = TRUE)
  paste(
    "@examples",
    # "\\dontrun{",
    'f <- system.file("extdata/dem.tif", package = "wbw")',
    "wbw_read_raster(f) |>",
    ifelse(
      is.null(args),
      paste0("  ", foo, "()"),
      paste0(
        "  ",
        foo,
        "(",
        paste(args, collapse = ", "),
        ")"
      )
    ),
    # "}",
    sep = "\n"
  )
}
