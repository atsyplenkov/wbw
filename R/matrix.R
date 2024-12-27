#' @exportS3Method as.matrix wbw::WhiteboxRaster
NULL

#' Return matrix from WhiteboxRaster
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return matrix
#' @export
`as.matrix.wbw::WhiteboxRaster` <- function(x, ...) {
  checkmate::assert_environment(wbw_env)
  # Convert the result to an explicit R matrix
  result <- wbw_env$wbw_to_matrix(x@source)
  as.matrix(result)
}