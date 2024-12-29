#' Dimensions of a WhiteboxRaster or WhiteboxVector objects
#' @rdname dimensions
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#'
#' @return \code{integer} 
#'
#' @export
num_cells <-
  S7::new_generic(
    name = "num_cells",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(num_cells, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@source$num_cells()
  }

#' @rdname dimensions
#' @keywords utils
#'
#' @export
wbw_rows <-
  S7::new_generic(
    name = "wbw_rows",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_rows, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@source$configs$rows
  }

#' @rdname dimensions
#' @keywords utils
#'
#' @export
wbw_cols <-
  S7::new_generic(
    name = "wbw_cols",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_cols, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@source$configs$columns
  }

#' Get WhiteboxRaster resolution
#' @rdname resolution
#' @keywords utils
#' 
#' @eval rd_input_raster("x")
#'
#' @return \code{double}
#' 
#' @export
wbw_res <-
  S7::new_generic(
    name = "wbw_res",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_res, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    c(
      x@source$configs$resolution_x,
      x@source$configs$resolution_y
    )
  }

#' @rdname resolution
#' @keywords utils
#'
#' @export
wbw_xres <-
  S7::new_generic(
    name = "wbw_xres",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_xres, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
      x@source$configs$resolution_x
  }

#' @rdname resolution
#' @keywords utils
#'
#' @export
wbw_yres <-
  S7::new_generic(
    name = "wbw_yres",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_yres, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
      x@source$configs$resolution_y
  }