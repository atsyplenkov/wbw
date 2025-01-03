raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "filter fails",
  {
    # Adaptive filter
    expect_error(
      wbw_adaptive_filter(x, filter_size_x = 10L)
    )
    expect_error(
      wbw_adaptive_filter(x, filter_size_y = 2)
    )
    expect_error(
      wbw_adaptive_filter(x, filter_size_y = c(1:2))
    )
    expect_error(
      wbw_adaptive_filter(x, filter_size_y = 1.5)
    )
    expect_error(
      wbw_adaptive_filter(x, threshold = "a")
    )
    expect_error(
      wbw_adaptive_filter("x", threshold = "a")
    )

    # Bilateral filter
    expect_error(
      wbw_bilateral_filter(x, sigma_dist = 10L)
    )
    expect_error(
      wbw_bilateral_filter(x, sigma_int = -2)
    )
    expect_error(
      wbw_bilateral_filter(x, sigma_dist = c(1:2))
    )
    expect_error(
      wbw_bilateral_filter(x, sigma_dist = 20.1)
    )
    expect_error(
      wbw_bilateral_filter(x, sigma_dist = "a")
    )
    expect_error(
      wbw_bilateral_filter("x", sigma_int = "a")
    )

    # Mean filter
    expect_error(
      wbw_mean_filter(x, filter_size_x = 10L)
    )
    expect_error(
      wbw_mean_filter(x, filter_size_y = 2)
    )
    expect_error(
      wbw_mean_filter(x, filter_size_y = c(1:2))
    )
    expect_error(
      wbw_mean_filter(x, filter_size_y = 1.5)
    )
    expect_error(
      wbw_mean_filter(x, filter_size_y = "a")
    )
    expect_error(
      wbw_mean_filter("x", filter_size_y = "a")
    )

    # Gaussian filter
    expect_error(
      wbw_gaussian_filter(x, sigma = 0.2)
    )
    expect_error(
      wbw_gaussian_filter(x, sigma = 1L)
    )
    expect_error(
      wbw_gaussian_filter("x", sigma = 1)
    )
    expect_error(
      wbw_gaussian_filter(x, sigma = 21)
    )
  }
)

test_that(
  "filter returns WhiteboxRaster",
  {
    # Adaptive filter
    expect_s7_class(
      wbw_adaptive_filter(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_adaptive_filter(x, filter_size_x = 3, filter_size_y = 3),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_adaptive_filter(x, threshold = 5),
      WhiteboxRaster
    )

    # Bilateral filter
    expect_s7_class(
      wbw_bilateral_filter(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_bilateral_filter(x, sigma_dist = 1.5),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_bilateral_filter(x, sigma_int = 2),
      WhiteboxRaster
    )

    # Mean filter
    expect_s7_class(
      wbw_mean_filter(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_mean_filter(x, filter_size_x = 3, filter_size_y = 3),
      WhiteboxRaster
    )

    # Gaussian filter
    expect_s7_class(
      wbw_gaussian_filter(x),
      WhiteboxRaster
    )
  }
)

test_that(
  "filter alters original DEM values",
  {
    # Here is near-equality check is happening. If two values are close to
    # be equal, i.e. 2.222222226 and 2.222222225, then all.equal() returns TRUE
    # In other cases the function will return the mean relative difference as
    # a character vector
    true_median <- median(x)

    # Adaptive filter
    expect_type(
      all.equal(
        median(wbw_adaptive_filter(x, filter_size_x = 51, filter_size_y = 51)),
        true_median
      ),
      "character"
    )

    # Bilateral filter
    expect_type(
      all.equal(
        median(wbw_bilateral_filter(x, sigma_dist = 5, sigma_int = 5)),
        true_median
      ),
      "character"
    )

    # Mean filter
    expect_type(
      all.equal(
        median(wbw_mean_filter(x, filter_size_x = 51, filter_size_y = 51)),
        true_median
      ),
      "character"
    )

    # Gaussian filter
    expect_type(
      all.equal(
        median(wbw_gaussian_filter(x, sigma = 5)),
        true_median
      ),
      "character"
    )
  }
)
