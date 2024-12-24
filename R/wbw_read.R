#' Returns a new Raster object, read into memory from a path-file string.
#' @export
wbw_read_raster <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "r")
  wbe$read_raster(file_name = file_name)
}

#' Reads a vector from disc into an in-memory Vector object.
#' @export
wbw_read_vector <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "v")
  wbe$read_vector(file_name = file_name)
}
