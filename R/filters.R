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
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
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
wbw_adaptive_filter <- S7::new_generic(
  name = "wbw_adaptive_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L, threshold = 2) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_adaptive_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L,
  threshold = 2
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  checkmate::assert_double(threshold, len = 1)
  # Filter
  out <- wbe$adaptive_filter(
    raster = x@source,
    filter_size_x = filter_size_x,
    filter_size_y = filter_size_y,
    threshold = threshold
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
#' distance parameter (\code{sigma_dist}); the larger the standard deviation the
#' larger the resulting filter kernel.
#' The standard deviation can be any number in the range
#' 0.5-20 and is specified in the unit of pixels. The standard deviation
#' intensity parameter (\code{sigma_int}), specified in the same units as the
#' z-values, determines the intensity domain contribution to kernel weightings.
#'
#' @eval rd_input_raster("x")
#' @param sigma_dist \code{double}, standard deviation distance parameter in
#' **pixels**.
#' @param sigma_int \code{double}, standard deviation intensity parameter,
#' in the same units as z-units of input raster \code{x} (usually, meters).
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
wbw_bilateral_filter <- S7::new_generic(
  name = "wbw_bilateral_filter",
  dispatch_args = "x",
  fun = function(x, sigma_dist = 0.75, sigma_int = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_bilateral_filter, WhiteboxRaster) <- function(
  x,
  sigma_dist = 0.75,
  sigma_int = 1
) {
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
  out <- wbe$bilateral_filter(
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
#' their smoothing compared to edge-preserving alternatives like the
#' [wbw_bilateral_filter] or [wbw_gaussian_filter].
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @references
#' Crow, F. C. (1984, January). Summed-area tables for texture mapping.
#' In ACM SIGGRAPH computer graphics (Vol. 18, No. 3, pp. 207-212). ACM.
#'
#' @seealso [wbw_bilateral_filter()], [wbw_gaussian_filter()]
#'
#' @eval rd_wbw_link("mean_filter")
#' @eval rd_example("wbw_mean_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_mean_filter <- S7::new_generic(
  name = "wbw_mean_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_mean_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  # Filter
  out <- wbe$mean_filter(
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
wbw_gaussian_filter <- S7::new_generic(
  name = "wbw_gaussian_filter",
  dispatch_args = "x",
  fun = function(x, sigma = 0.75) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_gaussian_filter, WhiteboxRaster) <- function(x, sigma = 0.75) {
  # Checks
  check_env(wbe)
  checkmate::assert_double(
    sigma,
    lower = 0.5,
    upper = 20,
    len = 1L
  )
  # Filter
  out <- wbe$gaussian_filter(
    raster = x@source,
    sigma = sigma
  )
  # Return Raster
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}

#' Conservative Smoothing Filter
#' @keywords image_processing
#'
#' @description
#' This tool performs a conservative smoothing filter on a raster image.
#' A conservative smoothing filter can be used to remove short-range
#' variability in an image, effectively acting to smooth the image.
#' It is particularly useful for eliminating local spikes and reducing the
#'  noise in an image.
#'
#' @details
#' The algorithm operates by calculating the minimum and maximum neighbouring
#'  values surrounding a grid cell. If the cell at the centre of the
#'  kernel is greater than the calculated maximum value, it is replaced
#' with the maximum value in the output image. Similarly, if the cell
#' value at the kernel centre is less than the neighbouring minimum value,
#' the corresponding grid cell in the output image is replaced with the
#' minimum value.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_bilateral_filter()], [wbw_gaussian_filter()],
#' [wbw_mean_filter()]
#'
#' @eval rd_wbw_link("conservative_smoothing_filter")
#' @eval rd_example("wbw_conservative_smoothing_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_conservative_smoothing_filter <- S7::new_generic(
  name = "wbw_conservative_smoothing_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 3L, filter_size_y = 3L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_conservative_smoothing_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 3L,
  filter_size_y = 3L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  # Filter
  out <- wbe$conservative_smoothing_filter(
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

#' High Pass Filter
#' @keywords image_processing
#'
#' @description
#' This tool performs a high-pass filter on a raster image. High-pass filters
#' can be used to emphasize the short-range variability in an image.
#' The algorithm operates essentially by subtracting the value at the grid
#'  cell at the centre of the window from the average value in the surrounding
#'  neighbourhood (i.e. window.)
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_high_pass_median_filter()]
#'
#' @eval rd_wbw_link("high_pass_filter")
#' @eval rd_example("wbw_high_pass_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_high_pass_filter <- S7::new_generic(
  name = "wbw_high_pass_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_high_pass_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  # Filter
  out <- wbe$high_pass_filter(
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

#' High Pass Median Filter
#' @keywords image_processing
#'
#' @description
#' This tool performs a high-pass median filter on a raster image.
#' High-pass filters can be used to emphasize the short-range variability in
#'  an image. The algorithm operates essentially by subtracting the value at
#' the grid cell at the centre of the window from the median value in the
#' surrounding neighbourhood (i.e. window.)
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#' @param sig_digits \code{integer}, default 2. Required for rounding of
#' floating points inputs.
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_median_filter()], [wbw_high_pass_filter()]
#'
#' @eval rd_wbw_link("high_pass_median_filter")
#' @eval rd_example("wbw_high_pass_median_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_high_pass_median_filter <- S7::new_generic(
  name = "wbw_high_pass_median_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L, sig_digits = 2L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_high_pass_median_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L,
  sig_digits = 2L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  sig_digits <- checkmate::asInteger(
    sig_digits,
    lower = 0L,
    len = 1L
  )
  # Filter
  out <- wbe$high_pass_median_filter(
    raster = x@source,
    filter_size_x = filter_size_x,
    filter_size_y = filter_size_y,
    sig_digits = sig_digits
  )
  # Return Raster
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}

#' Median Filter
#' @keywords image_processing
#'
#' @description
#' This tool performs a median filter on a raster image. Median filters, a
#' type of low-pass filter, can be used to emphasize the longer-range
#' variability in an image, effectively acting to smooth the image. This
#' can be useful for reducing the noise in an image.
#'
#' @details
#' The algorithm operates by calculating the median value (middle value in
#' a sorted list) in a moving window centred on each grid cell. Specifically,
#'  this tool uses the efficient running-median filtering algorithm of
#'  Huang et al. (1979). The median value is not influenced by
#' anomolously high or low values in the distribution to the extent
#' that the average is. As such, the median filter is far less sensitive
#' to shot noise in an image than the mean filter.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#' @param sig_digits \code{integer}, default 2. Required for rounding of
#' floating points inputs.
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_high_pass_filter()],
#' [wbw_high_pass_median_filter()]
#'
#' @references
#' Huang, T., Yang, G.J.T.G.Y. and Tang, G., 1979. A fast two-dimensional
#' median filtering algorithm. IEEE Transactions on Acoustics, Speech, and
#'  Signal Processing, 27(1), pp.13-18.
#'
#' @eval rd_wbw_link("median_filter")
#' @eval rd_example("wbw_median_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_median_filter <- S7::new_generic(
  name = "wbw_median_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L, sig_digits = 2L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_median_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L,
  sig_digits = 2L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  sig_digits <- checkmate::asInteger(
    sig_digits,
    lower = 0L,
    len = 1L
  )
  # Filter
  out <- wbe$median_filter(
    raster = x@source,
    filter_size_x = filter_size_x,
    filter_size_y = filter_size_y,
    sig_digits = sig_digits
  )
  # Return Raster
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}

#' Majority Filter
#' @keywords image_processing
#'
#' @description
#' Assigns each cell in the output grid the most frequently occurring value
#' (mode) in a moving window centred on each grid cell in the input raster.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_high_pass_filter()],
#' [wbw_high_pass_median_filter()]
#'
#' @eval rd_wbw_link("majority_filter")
#' @eval rd_example("wbw_majority_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_majority_filter <- S7::new_generic(
  name = "wbw_majority_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_majority_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$majority_filter(
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

#' Maximum Filter
#' @keywords image_processing
#'
#' @description
#' Assigns each cell in the output grid the maximum value in a moving window
#' centred on each grid cell in the input raster.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_high_pass_filter()],
#' [wbw_high_pass_median_filter()]
#'
#' @eval rd_wbw_link("maximum_filter")
#' @eval rd_example("wbw_maximum_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_maximum_filter <- S7::new_generic(
  name = "wbw_maximum_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_maximum_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$maximum_filter(
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

#' Minimum Filter
#' @keywords image_processing
#'
#' @description
#' Assigns each cell in the output grid the minimum value in a moving window
#' centred on each grid cell in the input raster.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()], [wbw_high_pass_filter()],
#' [wbw_high_pass_median_filter()]
#'
#' @eval rd_wbw_link("minimum_filter")
#' @eval rd_example("wbw_minimum_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_minimum_filter <- S7::new_generic(
  name = "wbw_minimum_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_minimum_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$minimum_filter(
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

#' Olympic Filter
#' @keywords image_processing
#'
#' @description
#' This filter is a modification of the [wbw_mean_filter], whereby
#' the highest and lowest values in the kernel are dropped, and the remaining
#'  values are averaged to replace the central pixel. The result is a
#' low-pass smoothing filter that is more robust than the [wbw_mean_filter],
#' which is more strongly impacted by the presence of outlier values.
#' It is named after a system of scoring Olympic events.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_mean_filter()]
#'
#' @eval rd_wbw_link("olympic_filter")
#' @eval rd_example("wbw_olympic_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_olympic_filter <- S7::new_generic(
  name = "wbw_olympic_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_olympic_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$olympic_filter(
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

#' Percentile Filter
#' @keywords image_processing
#'
#' @description
#' This tool calculates the percentile of the center cell in a moving filter
#' window applied to an input image (\code{x}). This indicates the value
#' below which a given percentage of the neighbouring values in within the
#' filter fall. For example, the 35th percentile is the value below which 35%
#' of the neighbouring values in the filter window may be found. As such,
#' the percentile of a pixel value is indicative of the relative location
#' of the site within the statistical distribution of values contained
#' within a filter window.
#'
#' When applied to input digital elevation models, percentile is a measure of
#' local topographic position, or elevation residual.
#'
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' This tool takes advantage of the redundancy between overlapping,
#' neighbouring filters to enhance computationally efficiency, using a
#' method similar to Huang et al. (1979). This efficient method of
#' calculating percentiles requires rounding of floating-point inputs,
#' and therefore the user must specify the number of significant
#' digits (\code{sig_digits}) to be used during the processing.
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#' @param sig_digits \code{integer}, default 2. Required for rounding of
#' floating points inputs.
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_median_filter()]
#'
#' @references
#' Huang, T., Yang, G.J.T.G.Y. and Tang, G., 1979. A fast two-dimensional
#' median filtering algorithm. IEEE Transactions on Acoustics, Speech, and
#'  Signal Processing, 27(1), pp.13-18.
#'
#' @eval rd_wbw_link("percentile_filter")
#' @eval rd_example("wbw_percentile_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_percentile_filter <- S7::new_generic(
  name = "wbw_percentile_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L, sig_digits = 2L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_percentile_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L,
  sig_digits = 2L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)
  sig_digits <- checkmate::asInteger(
    sig_digits,
    lower = 0L,
    len = 1L
  )
  # Filter
  out <- wbe$percentile_filter(
    raster = x@source,
    filter_size_x = filter_size_x,
    filter_size_y = filter_size_y,
    sig_digits = sig_digits
  )
  # Return Raster
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}

#' Range Filter
#' @keywords image_processing
#'
#' @description
#' A range filter assigns to each cell in the output grid the range
#'  (maximum - minimum) of the values contained within a moving window
#' centred on each grid cell.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_minimum_filter()], [wbw_maximum_filter()]
#'
#' @eval rd_wbw_link("range_filter")
#' @eval rd_example("wbw_range_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_range_filter <- S7::new_generic(
  name = "wbw_range_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_range_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$range_filter(
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

#' Total Filter
#' @keywords image_processing
#'
#' @description
#' A total filter assigns to each cell in the output grid the total (sum)
#' of all values in a moving window centred on each grid cell.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_minimum_filter()], [wbw_maximum_filter()],
#' [wbw_range_filter()], [wbw_majority_filter()]
#'
#' @eval rd_wbw_link("total_filter")
#' @eval rd_example("wbw_total_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_total_filter <- S7::new_generic(
  name = "wbw_total_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_total_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$total_filter(
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

#' Standard Deviation Filter
#' @keywords image_processing
#'
#' @description
#' A standard deviation filter assigns to each cell in the output grid the
#' standard deviation, a measure of dispersion, of the values contained within
#' a moving window centred on each grid cell.
#'
#' @details
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using \code{filter_size_x} and \code{filter_size_y} These dimensions should
#' be odd, positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' @eval rd_input_raster("x")
#' @param filter_size_x \code{integer}, X dimension of the neighbourhood size
#' @param filter_size_y \code{integer}, Y dimension of the neighbourhood size
#'
#' @return [WhiteboxRaster] object containing filtered values
#'
#' @seealso [wbw_minimum_filter()], [wbw_maximum_filter()],
#' [wbw_range_filter()], [wbw_majority_filter()], [wbw_total_filter()]
#'
#' @eval rd_wbw_link("standard_deviation_filter")
#' @eval rd_example("wbw_standard_deviation_filter",
#' c("filter_size_x = 3L", "filter_size_y = 3L"))
#'
#' @export
wbw_standard_deviation_filter <- S7::new_generic(
  name = "wbw_standard_deviation_filter",
  dispatch_args = "x",
  fun = function(x, filter_size_x = 11L, filter_size_y = 11L) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_standard_deviation_filter, WhiteboxRaster) <- function(
  x,
  filter_size_x = 11L,
  filter_size_y = 11L
) {
  # Checks
  check_env(wbe)
  filter_size_x <- checkmate::asInteger(
    filter_size_x,
    lower = 0L,
    len = 1L
  )
  filter_size_y <- checkmate::asInteger(
    filter_size_y,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_true(filter_size_x %% 2 == 1)
  checkmate::assert_true(filter_size_y %% 2 == 1)

  # Filter
  out <- wbe$standard_deviation_filter(
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
