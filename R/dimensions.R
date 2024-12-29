#' Dimensions of a WhiteboxRaster or WhiteboxVector objects
#' @rdname dimensions
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#'
#' @return \code{integer} 
#'
#' @export
ncell <-
  S7::new_generic(
    name = "ncell",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(ncell, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@source$num_cells()
  }

#' @rdname dimensions
#' @keywords utils
#'
#' @export
nrow <-
  S7::new_generic(
    name = "nrow",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(nrow, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    x@source$configs$rows
  }

#' @rdname dimensions
#' @keywords utils
#'
#' @export
ncol <-
  S7::new_generic(
    name = "ncol",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(ncol, WhiteboxRaster) <-
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
res <-
  S7::new_generic(
    name = "res",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(res, WhiteboxRaster) <-
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
xres <-
  S7::new_generic(
    name = "xres",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(xres, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
      x@source$configs$resolution_x
  }

#' @rdname resolution
#' @keywords utils
#'
#' @export
yres <-
  S7::new_generic(
    name = "yres",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(yres, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
      x@source$configs$resolution_y
  }