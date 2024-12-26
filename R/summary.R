#' Summary method for WhiteboxRaster
#' @param object [WhiteboxRaster] object
#' @param ... additional arguments passed to summary
#' @export
`summary.wbw::WhiteboxRaster` <-
  function(object, ...) {
    check_env(wbe)
    cat(
      wbe$raster_summary_stats(object@source)
    )
  }
