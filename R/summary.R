#' @exportS3Method max wbw::WhiteboxRaster
#' @exportS3Method min wbw::WhiteboxRaster
NULL

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

#' Get maximum value from WhiteboxRaster
#' @param object WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return numeric value
#' @export
`max.wbw::WhiteboxRaster` <- function(object, ...) {
  check_env(wbe)
  stats <- wbe$raster_summary_stats(object@source)
  extract_stat(stats, "maximum")
}

#' Get mean value from WhiteboxRaster
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return numeric value
#' @export
`mean.wbw::WhiteboxRaster` <- function(x, ...) {
  check_env(wbe)
  stats <- wbe$raster_summary_stats(x@source)
  extract_stat(stats, "average")
}

#' Get minimum value from WhiteboxRaster
#' @param object WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return numeric value
#' @export
`min.wbw::WhiteboxRaster` <- function(object, ...) {
  check_env(wbe)
  stats <- wbe$raster_summary_stats(object@source)
  extract_stat(stats, "minimum")
}


# Helper function to extract numeric value from a specific stat line
extract_stat <- function(stats_text, pattern) {
  line <- grep(pattern, strsplit(stats_text, "\n")[[1]], value = TRUE)
  as.numeric(sub(".*: ", "", line))
}
