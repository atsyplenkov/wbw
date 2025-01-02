#' Read Raster File as WhiteboxRaster
#' @rdname io
#' @keywords io
#'
#' @description
#' Creates a new [WhiteboxRaster] object by reading raster data from a file 
#' into memory.
#'
#' @param file_name \code{character}, path to raster file
#'
#' @return [WhiteboxRaster] object
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(raster_path)
#' }
#' 
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

#' Read Vector File as WhiteboxVector
#' @rdname io
#' @keywords io
#' 
#' @description
#' Creates a new [WhiteboxVector] object by reading vector data from an ESRI 
#' shapefile into memory.
#'
#' @param file_name \code{character}, path to ESRI shapefile
#' 
#' @return [WhiteboxVector] object
#'
#' @export
wbw_read_vector <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "v")
  wbe$read_vector(file_name = file_name)
}

#' Get File Name from Path
#'
#' @description
#' Extracts the file name from a full path string.
#'
#' @param path \code{character}, file path
#' @return \code{character}, file name
#'
#' @keywords internal
wbw_get_name <- function(path) {
  checkmate::assertFile(path, access = "r")
  names <- strsplit(path, "/")[[1]]
  enc2utf8(names[length(names)])
}
