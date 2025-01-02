#' @exportS3Method as.matrix wbw::WhiteboxRaster
#' @exportS3Method as.vector wbw::WhiteboxRaster
NULL

#' Return matrix from WhiteboxRaster
#' @rdname matrix
#' @keywords transform
#'
#' @param x [WhiteboxRaster] object
#' @param raw logical. Should the raw data be returned (`raw = TRUE`) or
#' the `NoData` values should be transformed to `NA` (`raw = FALSE`).
#' @param ... additional arguments (not used)
#'
#' @return matrix
#'
#' @export
`as.matrix.wbw::WhiteboxRaster` <- function(x, raw = FALSE, ...) {
  checkmate::assert_environment(wbw_env)
  m <- wbw_env$wbw_to_matrix(x@source)
  m <- as.matrix(m)

  if (!raw) {
    wbw_nodata <- x@source$configs$nodata
    m[m == wbw_nodata] <- NA
  }

  m
}

#' @rdname matrix
#' @keywords transform
#'
#' @eval rd_input_raster("x")
#'
#' @eval rd_example("as_matrix")
as_matrix <-
  S7::new_generic(
    name = "as_matrix",
    dispatch_args = "x",
    fun = function(x, raw = FALSE) {
      S7::S7_dispatch()
    }
  )

S7::method(as_matrix, WhiteboxRaster) <-
  function(x, raw = FALSE) {
    checkmate::assert_environment(wbw_env)
    m <- wbw_env$wbw_to_matrix(x@source)
    m <- as.matrix(m)

    if (!raw) {
      wbw_nodata <- x@source$configs$nodata
      m[m == wbw_nodata] <- NA
    }

    m
  }


#' Return vector from WhiteboxRaster
#' @rdname vector
#' @keywords transform
#'
#' @param x WhiteboxRaster object
#' @param mode the type of vector to create (ignored)
#' @param raw logical. Should the raw data be returned (`raw = TRUE`) or
#' the `NoData` values should be transformed to `NA` (`raw = FALSE`).
#' @param ... additional arguments (not used)
#'
#' @return vector
#'
#' @export
`as.vector.wbw::WhiteboxRaster` <- function(x, mode = "any", raw = FALSE, ...) {
  checkmate::assert_environment(wbw_env)
  v <- wbw_env$wbw_to_vector(x@source)
  v <- as.vector(v)

  if (!raw) {
    wbw_nodata <- x@source$configs$nodata
    v[v == wbw_nodata] <- NA
  }

  v
}

#' @rdname vector
#' @keywords transform
#'
#' @eval rd_input_raster("x")
#'
#' @eval rd_example("as_vector")
as_vector <-
  S7::new_generic(
    name = "as_vector",
    dispatch_args = "x",
    fun = function(x, raw = FALSE) {
      S7::S7_dispatch()
    }
  )

S7::method(as_vector, WhiteboxRaster) <-
  function(x, raw = FALSE) {
    checkmate::assert_environment(wbw_env)
    v <- wbw_env$wbw_to_vector(x@source)
    v <- as.vector(v)

    if (!raw) {
      wbw_nodata <- x@source$configs$nodata
      v[v == wbw_nodata] <- NA
    }

    v
  }
