#' @exportS3Method as.matrix wbw::WhiteboxRaster
#' @exportS3Method as.vector wbw::WhiteboxRaster
NULL

#' Return matrix from WhiteboxRaster
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

#' Return vector from WhiteboxRaster
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