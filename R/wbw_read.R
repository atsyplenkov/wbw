#' Returns a new Raster object, read into memory from a path-file string.
#' @export
wbw_read_raster <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "r")
  r <- wbe$read_raster(file_name = file_name)
  WbwRaster(
    name = wbw_get_name(file_name),
    source = r
  )
}

#' Reads a vector from disc into an in-memory Vector object.
#' @export
wbw_read_vector <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "v")
  wbe$read_vector(file_name = file_name)
}

wbw_get_name <- function(path) {
  checkmate::assertFile(path, access = "r")
  names <- strsplit(path, "/")[[1]]
  names[length(names)]
}
