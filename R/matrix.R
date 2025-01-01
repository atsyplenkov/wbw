#' @exportS3Method as.matrix wbw::WhiteboxRaster
#' @exportS3Method as.vector wbw::WhiteboxRaster
NULL

#' Return matrix from WhiteboxRaster
#' @rdname matrix
#' @keywords transform
#'
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#'
#' @return matrix
#'
#' @export
`as.matrix.wbw::WhiteboxRaster` <- function(x, ...) {
  checkmate::assert_environment(wbw_env)
  # Convert the result to an explicit R matrix
  result <- wbw_env$wbw_to_matrix(x@source)
  as.matrix(result)
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
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(as_matrix, WhiteboxRaster) <-
  function(x) {
    checkmate::assert_environment(wbw_env)
    result <- wbw_env$wbw_to_matrix(x@source)
    as.matrix(result)
  }


#' Return vector from WhiteboxRaster
#' @rdname vector
#' @keywords transform
#'
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#'
#' @return vector
#'
#' @export
`as.vector.wbw::WhiteboxRaster` <- function(x, ...) {
  checkmate::assert_environment(wbw_env)
  # Convert the result to an explicit R matrix
  result <- wbw_env$wbw_to_vector(x@source)
  as.vector(result)
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
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(as_vector, WhiteboxRaster) <-
  function(x) {
    checkmate::assert_environment(wbw_env)
    result <- wbw_env$wbw_to_vector(x@source)
    as.vector(result)
  }