#' Returns a new WhiteboxRaster object, read into memory from a 
#' path-file string.
#'
#' @param file_name \code{character}, path to raster file.
#'
#' @return [WhiteboxRaster] object
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(raster_path)
#' }
#' @export
wbw_read_raster <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "r")
  r <- wbe$read_raster(file_name = file_name)
  WhiteboxRaster(
    name = wbw_get_name(file_name),
    source = r
  )
}

#' Reads a vector from disc into an in-memory WbwVector object.
#' @param file_name \code{character}, path to ESRI shapefile.
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
