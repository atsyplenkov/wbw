#' Convert WhiteboxRaster to Matrix
#' @rdname matrix
#' @keywords transform
#'
#' @description
#' Converts a WhiteboxRaster object to a matrix. The output maintains the same
#' dimensions and cell values as the input raster.
#'
#' @param raw logical. Should the raw data be returned (`raw = TRUE`) or should
#'   NoData values be transformed to `NA` (`raw = FALSE`)?
#' @eval rd_input_raster("x")
#'
#' @return matrix containing raster values
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

#' Convert objects to vectors
#' @name as_vector
#' @rdname vector
#' @keywords transform
#' 
#' @description
#' Converts various Whitebox objects to vectors:
#' * For [WhiteboxRaster]: converts raster values to a vector in row-major order
#' * For [WhiteboxExtent]: converts extent boundaries to a named vector
#'
#' @param x Object to convert to vector. Can be:
#'   * A [WhiteboxRaster] object
#'   * A [WhiteboxExtent] object
#' @param raw logical. For [WhiteboxRaster] only: Should the raw data be returned
#'   (`raw = TRUE`) or should NoData values be transformed to `NA` (`raw = FALSE`)?
#' 
#' @return A vector, with type depending on the input:
#' * For [WhiteboxRaster]: vector containing raster values
#' * For [WhiteboxExtent]: named vector containing extent values
#'
#' @usage
#' \S4method{as_vector}{WhiteboxRaster}(x, raw = FALSE)
#' \S4method{as_vector}{WhiteboxExtent}(x)
#'
#' @aliases as_vector,WhiteboxRaster-method as_vector,WhiteboxExtent-method
#'
#' @examples
#' f <- system.file("extdata/dem.tif", package = "wbw")
#' x <- wbw_read_raster(f)
#' 
#' # Return WhiteboxRaster's data:
#' head(as_vector(x))
#' 
#' # Return WhiteboxExtent's data:
#' as_vector(wbw_ext(x))
#'
#' @export
as_vector <- S7::new_generic(
  name = "as_vector",
  dispatch_args = "x"
)

S7::method(as_vector, WhiteboxRaster) <- function(x, raw = FALSE) {
  checkmate::assert_environment(wbw_env)
  v <- wbw_env$wbw_to_vector(x@source)
  v <- as.vector(v)

  if (!raw) {
    wbw_nodata <- x@source$configs$nodata
    v[v == wbw_nodata] <- NA
  }

  v
}

S7::method(as_vector, WhiteboxExtent) <- function(x) {
  c(
    "west" = x@west,
    "east" = x@east,
    "south" = x@south,
    "north" = x@north
  )
}
