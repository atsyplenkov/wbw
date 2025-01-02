#' Return matrix from WhiteboxRaster
#' @rdname matrix
#' @keywords transform
#'
#' @param raw logical. Should the raw data be returned (`raw = TRUE`) or
#' should `NoData` values be transformed to `NA` (`raw = FALSE`)?
#' @eval rd_input_raster("x")
#'
#' @return matrix
#'
#' @eval rd_example("as_matrix", args = c("raw = TRUE"))
#'
#' @export
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
#' @param raw logical. Should the raw data be returned (`raw = TRUE`) or
#' should `NoData` values be transformed to `NA` (`raw = FALSE`)?
#' @eval rd_input_raster("x")
#'
#' @return vector
#'
#' @eval rd_example("as_vector")
#'
#' @export
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
