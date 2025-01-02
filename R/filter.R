#' Adaptive Filter
#' @keywords image_processing
#'
#' @description
#' Applies an adaptive filter to reduce random noise (shot noise) in a raster 
#' image. The filter modifies pixel values only where they differ substantially 
#' from their neighbors.
#'
#' @details
#' The algorithm calculates the average value in a moving window centered on 
#' each grid cell. If the absolute difference between the window mean and the 
#' center cell value exceeds the user-defined threshold, the output cell is 
#' assigned the mean value. Otherwise, it retains its original value.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using `filter_size_x` and `filter_size_y` These dimensions should be odd,
#' positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#' @param threshold \code{double}
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @eval rd_wbw_link("adaptive_filter")
#' @eval rd_example("wbw_adaptive_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
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
    filter_size_x <-
      checkmate::asInteger(
        filter_size_x,
        lower = 0L,
        len = 1L
      )
    filter_size_y <-
      checkmate::asInteger(
        filter_size_y,
        lower = 0L,
        len = 1L
      )
    checkmate::assert_true(filter_size_x %% 2 == 1)
    checkmate::assert_true(filter_size_y %% 2 == 1)
    checkmate::assert_double(threshold, len = 1)
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

#' Bilateral Filter
#' @keywords image_processing
#'
#' @description
#' Applies an edge-preserving smoothing filter that reduces noise while
#' preserving important edges in the image.
#'
#' @details
#' Bilateral filtering is a non-linear technique introduced by Tomasi and
#' Manduchi (1998). The filter combines spatial and intensity domains to
#' preserve edges while smoothing. Unlike the Gaussian filter, the bilateral
#' filter weights pixels based on both their spatial distance and intensity
#' similarity to the center pixel.
#'
#' The size of the filter is determined by setting the standard deviation
#' distance parameter (`sigma_dist`); the larger the standard deviation the
#' larger the resulting filter kernel.
#' The standard deviation can be any number in the range
#' 0.5-20 and is specified in the unit of pixels. The standard deviation
#' intensity parameter (`sigma_int`), specified in the same units as the
#' z-values, determines the intensity domain contribution to kernel weightings.
#'
#' @eval rd_input_raster("x")
#' @param sigma_dist \code{double}, standard deviation distance parameter in
#' **pixels**.
#' @param sigma_int \code{double}, standard deviation intensity parameter,
#' in the same units as z-units of input raster `x` (usually, meters).
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_gaussian_filter()]
#'
#' @references
#' Tomasi, C., & Manduchi, R. (1998, January). Bilateral filtering for gray
#' and color images. In null (p. 839). IEEE.
#'
#' @eval rd_wbw_link("bilateral_filter")
#' @eval rd_example("wbw_bilateral_filter",
#' c("sigma_dist = 1.5", "sigma_int = 1.1"))
#'
#' @export
wbw_bilateral_filter <-
  S7::new_generic(
    name = "wbw_bilateral_filter",
    dispatch_args = "x",
    fun = function(x, sigma_dist = 0.75, sigma_int = 1) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_bilateral_filter, WhiteboxRaster) <-
  function(x, sigma_dist = 0.75, sigma_int = 1) {
    # Checks
    check_env(wbe)
    checkmate::assert_double(
      sigma_dist,
      lower = 0.5,
      upper = 20,
      len = 1L
    )
    checkmate::assert_double(
      sigma_int,
      lower = 0,
      len = 1L
    )
    # Filter
    out <-
      wbe$bilateral_filter(
        raster = x@source,
        sigma_dist = sigma_dist,
        sigma_int = sigma_int
      )
    # Return Raster
    WhiteboxRaster(
      name = x@name,
      source = out
    )
  }

#' Mean Filter
#' @keywords image_processing
#'
#' @description
#' Applies a mean filter (low-pass filter) to smooth an image by emphasizing
#' longer-range variability and reducing noise.
#'
#' @details
#' Uses an efficient integral image approach (Crow, 1984) that is independent
#' of filter size. While commonly used, mean filters can be more aggressive in
#' their smoothing compared to edge-preserving alternatives like the bilateral
#' filter or Gaussian filter.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using `filter_size_x` and `filter_size_y` These dimensions should be odd,
#' positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_bilateral_filter()], [wbw_gaussian_filter()]
#'
#' @eval rd_wbw_link("mean_filter")
#' @eval rd_example("wbw_mean_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_mean_filter <-
  S7::new_generic(
    name = "wbw_mean_filter",
    dispatch_args = "x",
    fun = function(x,
                   filter_size_x = 11L,
                   filter_size_y = 11L) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_mean_filter, WhiteboxRaster) <-
  function(x,
           filter_size_x = 11L,
           filter_size_y = 11L) {
    # Checks
    check_env(wbe)
    filter_size_x <-
      checkmate::asInteger(
        filter_size_x,
        lower = 0L,
        len = 1L
      )
    filter_size_y <-
      checkmate::asInteger(
        filter_size_y,
        lower = 0L,
        len = 1L
      )
    checkmate::assert_true(filter_size_x %% 2 == 1)
    checkmate::assert_true(filter_size_y %% 2 == 1)
    # Filter
    out <-
      wbe$mean_filter(
        raster = x@source,
        filter_size_x = filter_size_x,
        filter_size_y = filter_size_y
      )
    # Return Raster
    WhiteboxRaster(
      name = x@name,
      source = out
    )
  }

#' Gaussian Filter
#' @keywords image_processing
#'
#' @description
#' Applies a Gaussian smoothing filter to reduce noise while better preserving
#' image features compared to a simple mean filter.
#'
#' @details
#' The filter applies a 2D Gaussian kernel that weights pixels based on their
#' distance from the center. This gradual weighting makes it more effective for
#' noise reduction than the mean filter. The filter size is controlled by the
#' sigma parameter (0.5-20 grid cells).
#'
#' @eval rd_input_raster("x")
#' @param sigma \code{double}, standard deviation distance parameter in
#' **units of grid cells**. Should be in the range 0.5-20.
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()]
#'
#' @eval rd_wbw_link("gaussian_filter")
#' @eval rd_example("wbw_gaussian_filter", c("sigma = 1.5"))
#'
#' @export
wbw_gaussian_filter <-
  S7::new_generic(
    name = "wbw_gaussian_filter",
    dispatch_args = "x",
    fun = function(x, sigma = 0.75) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_gaussian_filter, WhiteboxRaster) <-
  function(x, sigma = 0.75) {
    # Checks
    check_env(wbe)
    checkmate::assert_double(
      sigma,
      lower = 0.5,
      upper = 20,
      len = 1L
    )
    # Filter
    out <-
      wbe$gaussian_filter(
        raster = x@source,
        sigma = sigma
      )
    # Return Raster
    WhiteboxRaster(
      name = x@name,
      source = out
    )
  }
