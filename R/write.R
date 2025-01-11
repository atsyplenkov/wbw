#' Writes an in-memory WhiteboxRaster object to file.
#' @rdname wbw_write_raster
#' @keywords io
#'
#' @description
#' Writes an in-memory WhiteboxRaster object to a file in a supported raster
#' format.
#'
#' @eval rd_wbw_link("write_raster")
#' @eval rd_input_raster("x")
#'
#' @param file_name \code{character} Path to output file
#' @param compress \code{logical} Whether to compress the output file
#'
#' @details
#' Supported raster formats:
#' - GeoTIFF (*.tif, *.tiff)
#' - Big GeoTIFF (*.tif, *.tiff)
#' - SAGA Binary (*.sdat, *.sgrd)
#' - Idrisi (*.rst, *.rdc)
#' - Surfer (*.grd)
#' - ESRI Binary (*.flt)
#' - ESRI BIL (*.bil)
#'
#' The tool can read GeoTIFFs compressed using PackBits, DEFLATE, or LZW
#' methods.
#'
#' When writing GeoTIFFs, use `compress=TRUE` to enable DEFLATE compression.
#'
#' @export
wbw_write_raster <- S7::new_generic(
  name = "wbw_write_raster",
  dispatch_args = "x",
  fun = function(x, file_name, compress = TRUE) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_write_raster, WhiteboxRaster) <- function(
  x,
  file_name,
  compress = TRUE
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(compress, len = 1)
  # Write
  wbe$write_raster(x@source, file_name = file_name, compress = compress)
}
