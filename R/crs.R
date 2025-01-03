#' Get WhiteboxExtent
#' @keywords crs
#'
#' @eval rd_input_raster("x")
#'
#' @export
wbw_ext <-
  S7::new_generic(
    name = "wbw_ext",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_ext, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@extent
  }
