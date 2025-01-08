#' Get WhiteboxExtent
#' @keywords crs
#'
#' @eval rd_input_raster("x")
#'
#' @examples
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(f) |>
#'   wbw_ext()
#' @export
wbw_ext <-
  S7::new_generic(
    name = "wbw_ext",
    dispatch_args = "x",
    fun = function(x) {
      # Add some input validation
      S7::S7_dispatch()
    }
  )

S7::method(wbw_ext, WhiteboxRaster) <-
  function(x) {
    # Checks
    conf <- x@source$configs
    WhiteboxExtent(
      west = conf$west,
      east = conf$east,
      south = conf$south,
      north = conf$north
    )
  }
