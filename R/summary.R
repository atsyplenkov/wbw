#' @importFrom stats median
NULL

#' @exportS3Method max wbw::WhiteboxRaster
#' @exportS3Method min wbw::WhiteboxRaster
#' @exportS3Method median wbw::WhiteboxRaster
NULL

#' Summary method for WhiteboxRaster
#' @rdname summarize
#' @docType methods
#' 
#' @description
#' Compute summary statistics for cells in [WhiteboxRaster].
#'
#' @param object [WhiteboxRaster] object
#' @param ... additional arguments passed to summary
#'
#' @eval rd_example("summary")
#' @eval rd_wbw_link("raster_summary_stats")
#'
#' @export
`summary.wbw::WhiteboxRaster` <-
  function(object, ...) {
    cat(
      wbe$raster_summary_stats(object@source)
    )
  }

#' @rdname summarize
#' @docType methods
#'
#' @param object WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return numeric value
#'
#' @eval rd_example("max")
#'
#' @export
`max.wbw::WhiteboxRaster` <- function(object, ...) {
  check_env(wbe)
  stats <- wbe$raster_summary_stats(object@source)
  extract_stat(stats, "maximum")
}

#' @rdname summarize
#' @docType methods
#'
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#'
#' @eval rd_example("mean")
#'
#' @export
`mean.wbw::WhiteboxRaster` <- function(x, ...) {
  x@source$calculate_mean()
}

#' @rdname summarize
#' @docType methods
#'
#' @param x WhiteboxRaster object
#' @param na.rm logical indicating whether NA values should 
#' be stripped (not used)
#' @param ... additional arguments (not used)
#'
#' @eval rd_example("median")
#'
#' @export
`median.wbw::WhiteboxRaster` <- function(x, na.rm = FALSE, ...) {
  x@source$calculate_clip_values(percent = 50)[[1]]
}

#' @rdname summarize
#' @docType methods
#'
#' @param object WhiteboxRaster object
#' @param ... additional arguments (not used)
#'
#' @eval rd_example("min")
#'
#' @export
`min.wbw::WhiteboxRaster` <- function(object, ...) {
  check_env(wbe)
  stats <- wbe$raster_summary_stats(object@source)
  extract_stat(stats, "minimum")
}

#' @rdname summarize
#' @docType methods
#'
#' @param x WhiteboxRaster object
#'
#' @eval rd_example("stdev")
#'
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

#' @rdname summarize
#' @docType methods
#'
#' @param x WhiteboxRaster object
#'
#' @eval rd_example("variance")
#'
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
