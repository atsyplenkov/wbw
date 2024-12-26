wbw_to_matrix <- function(raster) {
  checkmate::assert_environment(wbw_env)
  wbw_env$wbw_to_matrix(raster)
}
