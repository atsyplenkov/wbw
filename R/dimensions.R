#' Get dimensions of a WhiteboxRaster or WhiteboxVector object
#' @rdname dimensions
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#'
#' @return \code{integer} Number of cells in the raster
#'
#' @export
num_cells <- S7::new_generic(
  name = "num_cells",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(num_cells, WhiteboxRaster) <- function(x) {
  # Checks
  check_env(wbe)
  x@source$num_cells()
}

#' @rdname dimensions
#' @keywords utils
#'
#' @export
wbw_rows <- S7::new_generic(
  name = "wbw_rows",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_rows, WhiteboxRaster) <- function(x) {
  # Checks
  check_env(wbe)
  x@source$configs$rows
}

#' @rdname dimensions
#' @keywords utils
#'
#' @export
wbw_cols <- S7::new_generic(
  name = "wbw_cols",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_cols, WhiteboxRaster) <- function(x) {
  # Checks
  check_env(wbe)
  x@source$configs$columns
}

#' Get WhiteboxRaster resolution (x and y)
#' @rdname resolution
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#'
#' @return \code{double} Vector containing x and y resolution
#'
#' @export
wbw_res <- S7::new_generic(
  name = "wbw_res",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_res, WhiteboxRaster) <- function(x) {
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
wbw_xres <- S7::new_generic(
  name = "wbw_xres",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_xres, WhiteboxRaster) <- function(x) {
  # Checks
  check_env(wbe)
  x@source$configs$resolution_x
}

#' @rdname resolution
#' @keywords utils
#'
#' @export
wbw_yres <- S7::new_generic(
  name = "wbw_yres",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_yres, WhiteboxRaster) <- function(x) {
  # Checks
  check_env(wbe)
  x@source$configs$resolution_y
}

#' Get WhiteboxRaster data type
#' @rdname datatype
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#' @eval rd_example("wbw_data_type")
#'
#' @return \code{character} String representing the raster data type
#'
#' @export
wbw_data_type <- S7::new_generic(
  name = "wbw_data_type",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_data_type, WhiteboxRaster) <- function(x) {
  as.character(x@source$configs$data_type)
}

#' @rdname datatype
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#' @eval rd_example("wbw_is_int")
#'
#' @export
wbw_is_int <- S7::new_generic(
  name = "wbw_is_int",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_is_int, WhiteboxRaster) <- function(x) {
  wbw_type <- as.character(x@source$configs$data_type)

  any(
    wbw_type == "RasterDataType.I32",
    wbw_type == "RasterDataType.U32",
    wbw_type == "RasterDataType.I64",
    wbw_type == "RasterDataType.U64",
    wbw_type == "RasterDataType.I16",
    wbw_type == "RasterDataType.I8",
    wbw_type == "RasterDataType.U16",
    wbw_type == "RasterDataType.U8"
  )
}

#' @rdname datatype
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#' @eval rd_example("wbw_is_float")
#'
#' @export
wbw_is_float <- S7::new_generic(
  name = "wbw_is_float",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_is_float, WhiteboxRaster) <- function(x) {
  wbw_type <- as.character(x@source$configs$data_type)

  any(
    wbw_type == "RasterDataType.F32",
    wbw_type == "RasterDataType.F64"
  )
}

#' @rdname datatype
#' @keywords utils
#'
#' @eval rd_input_raster("x")
#' @eval rd_example("wbw_is_rgb")
#'
#' @export
wbw_is_rgb <- S7::new_generic(
  name = "wbw_is_rgb",
  dispatch_args = "x",
  fun = function(x) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_is_rgb, WhiteboxRaster) <- function(x) {
  wbw_type <- as.character(x@source$configs$data_type)

  any(
    wbw_type == "RasterDataType.RGB48",
    wbw_type == "RasterDataType.RGB24",
    wbw_type == "RasterDataType.RGBA32"
  )
}
