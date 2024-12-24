#' Writes an in-memory Raster object to file.
#' 
#' @eval rd_wbw_link("write_raster")
#' @eval rd_input_raster("raster")
#' 
#' @param file_name \code{character}, path to output file
#' @param compress \code{logical}, whether to compress the output file
#' 
#' @export
wbw_write_raster <-
  function(raster,
           file_name,
           compress = TRUE) {
    check_env(wbe)
    check_input_raster(raster)
    checkmate::assert_logical(compress)
    wbe$write_raster(raster, file_name = file_name, compress = compress)
  }
