#' Adaptive filter
#' @rdname wbw_adaptive_filter
#'
#' @description
#' This tool calculates slope gradient (i.e. slope steepness in degrees,
#' radians, or percent) for each grid cell in an input digital elevation
#' model (DEM).
#'
#' @details
#' This tool performs a type of adaptive filter on a raster image. An adaptive
#'  filter can be used to reduce the level of random noise (shot noise) in an
#' image. The algorithm operates by calculating the average value in a moving
#' window centred on each grid cell. If the absolute difference between the
#' window mean value and the centre grid cell value is beyond a user-defined
#' threshold (`threshold`), the grid cell in the output image is assigned the
#' mean value, otherwise it is equivalent to the original value. Therefore,
#' the algorithm only modifies the image where grid cell values are
#' substantially different than their neighbouring values.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using `filter_size_x` and `filter_size_y` These dimensions should be odd,
#' positive integer values (e.g. 3, 5, 7, 9, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#' @param threshold \code{double}
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @eval rd_wbw_link("adaptive_filter")
#' @eval rd_example_geomorph("wbw_adaptive_filter")
#'
#' @export
wbw_adaptive_filter <-
  S7::new_generic(
    name = "wbw_adaptive_filter",
    dispatch_args = "x",
    fun = function(x,
                   filter_size_x = 11L,
                   filter_size_y = 11L,
                   threshold = 2) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_adaptive_filter, WhiteboxRaster) <-
  function(x,
           filter_size_x = 11L,
           filter_size_y = 11L,
           threshold = 2) {
    # Checks
    check_env(wbe)
    checkmate::assert_integer(filter_size_x, lower = 0)
    checkmate::assert_integer(filter_size_y, lower = 0)
    checkmate::assert_true(filter_size_x %% 2 == 1)
    checkmate::assert_true(filter_size_y %% 2 == 1)
    checkmate::assert_double(threshold)
    # Filter
    out <-
      wbe$adaptive_filter(
        raster = x@source, filter_size_x = filter_size_x,
        filter_size_y = filter_size_y, threshold = threshold
      )
    # Return Raster
    WhiteboxRaster(
      name = x@name,
      source = out
    )
  }
