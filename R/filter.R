#' Adaptive filter
#' @keywords image_processing
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

#' Bilateral filter
#' @keywords image_processing
#'
#' @description
#' This tool can be used to perform an edge-preserving smoothing filter, or
#' bilateral filter, on an image. A bilateral filter can be used to emphasize
#' the longer-range variability in an image, effectively acting to smooth the
#'  image, while reducing the edge blurring effect common with other types of
#'  smoothing filters. As such, this filter is very useful for reducing the
#' noise in an image.
#'
#' @details
#' Bilateral filtering is a non-linear filtering technique introduced by Tomasi
#' and Manduchi (1998). The algorithm operates by convolving a kernel of
#' weights with each grid cell and its neighbours in an image. The bilateral
#' filter is related to Gaussian smoothing, in that the weights of the
#' convolution kernel are partly determined by the 2-dimensional Gaussian
#' (i.e. normal) curve, which gives stronger weighting to cells nearer the
#' kernel centre. Unlike the [wbw_gaussian_filter], however, the bilateral 
#' kernel weightings are also affected by their similarity to the 
#' intensity value of the central pixel. 
#' Pixels that are very different in intensity from the
#' central pixel are weighted less, also based on a Gaussian weight
#' distribution. Therefore, this non-linear convolution filter is determined
#' by the spatial and intensity domains of a localized pixel neighborhood.
#'
#' The heavier weighting given to nearer and similar-valued pixels makes the
#'  bilateral filter an attractive alternative for image smoothing and noise
#' reduction compared to the much-used [wbw_mean_filter].
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

#' Mean filter
#' @keywords image_processing
#'
#' @description
#' This tool performs a mean filter operation on a raster image. A mean filter,
#' a type of low-pass filter, can be used to emphasize the longer-range
#'  variability in an image, effectively acting to smooth the image.
#' This can be useful for reducing the noise in an image.
#'
#' @details
#' This tool utilizes an integral image approach (Crow, 1984) to ensure highly
#' efficient filtering that is invariant to filter size. The algorithm
#' operates by calculating the average value in a moving window centred on
#' each grid cell.
#'
#' Neighbourhood size, or filter size, is specified in the x and y dimensions
#' using `filter_size_x` and `filter_size_y` These dimensions should be odd,
#' positive integer values (e.g. 3L, 5L, 7L, 9L, etc.).
#'
#' Although commonly applied in digital image processing, mean filters are
#' generally considered to be quite harsh, with respect to their impact on the
#' image, compared to other smoothing filters such as the edge-preserving
#' smoothing filters including the [wbw_bilateral_filter],
#' `median_filter`, `olympic_filter`, `edge_preserving_mean_filter` and even
#' [wbw_gaussian_filter].
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

#' Gaussian filter
#' @keywords image_processing
#'
#' @description
#' This tool can be used to perform a Gaussian filter on a raster image.
#' A Gaussian filter can be used to emphasize the longer-range variability in
#' an image, effectively acting to smooth the image. This can be useful for
#' reducing the noise in an image.
#'
#' @details
#' The algorithm operates by convolving a kernel of weights with each grid cell
#' and its neighbours in an image. The weights of the convolution kernel are
#' determined by the 2-dimensional Gaussian (i.e. normal) curve, which gives
#' stronger weighting to cells nearer the kernel centre. It is this
#' characteristic that makes the Gaussian filter an attractive alternative for
#' image smoothing and noise reduction than the [wbw_mean_filter].
#' The size of the filter is determined by setting the
#' standard deviation parameter (`sigma`), which is in units of grid cells;
#' the larger the standard deviation the larger the resulting filter kernel.
#' The standard deviation can be any number in the range 0.5-20.
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
