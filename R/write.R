#' Writes an in-memory WhiteboxRaster object to file.
#' @rdname wbw_write_raster
#' @keywords io
#'
#' @eval rd_wbw_link("write_raster")
#' @eval rd_input_raster("x")
#'
#' @param file_name \code{character}, path to output file
#' @param compress \code{logical}, whether to compress the output file
#'
#' @details
#' Supported raster formats are GeoTIFF (`*.tif`, `*.tiff`), Big GeoTIFF
#' (`*.tif`, `*.tiff`), SAGA Binary (`*.sdat` and `*.sgrd`),
#' Idrisi (`*.rst` and `*.rdc`), Surfer (`*.grd`),
#' Esri Binary (`*.flt`), Esri BIL (`*.bil`).
#' 
#' `wbw` is able to read GeoTIFFs compressed using the PackBits, DEFLATE, and
#' LZW methods. Compressed GeoTIFFs, created using the DEFLATE algorithm, can
#'  also be output from any tool that generates raster output files by using 
#' `compress=True`.
#'
#' @export
wbw_write_raster <-
  S7::new_generic(
    name = "wbw_write_raster",
    dispatch_args = "x",
    fun = function(x, file_name, compress = TRUE) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_write_raster, WhiteboxRaster) <-
  function(x, file_name, compress = TRUE) {
    # Checks
    check_env(wbe)
    checkmate::assert_logical(compress, len = 1)
    # Write
    wbe$write_raster(x@source, file_name = file_name, compress = compress)
  }
