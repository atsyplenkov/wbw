#' @exportS3Method max wbw::WhiteboxRaster
#' @exportS3Method min wbw::WhiteboxRaster
NULL

#' Summary method for WhiteboxRaster
#' @param object [WhiteboxRaster] object
#' @param ... additional arguments passed to summary
#' @export
`summary.wbw::WhiteboxRaster` <-
  function(object, ...) {
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

#' Get Standard Deviation value from WhiteboxRaster
#' @param x WhiteboxRaster object
#' @return numeric value
#' @export
stdev <-
  S7::new_generic(
    name = "stdev",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(stdev, WhiteboxRaster) <-
  function(x) {
    check_env(wbe)
    stats <- wbe$raster_summary_stats(x@source)
    extract_stat(stats, "standard deviation")
  }

#' Get Variance value from WhiteboxRaster
#' @param x WhiteboxRaster object
#' @return numeric value
#' @export
variance <-
  S7::new_generic(
    name = "variance",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(variance, WhiteboxRaster) <-
  function(x) {
    check_env(wbe)
    stats <- wbe$raster_summary_stats(x@source)
    extract_stat(stats, "variance")
  }

# Helper function to extract numeric value from a specific stat line
extract_stat <- function(stats_text, pattern) {
  line <- grep(pattern, strsplit(stats_text, "\n")[[1]], value = TRUE)
  as.numeric(sub(".*: ", "", line))
}
