source("setup.R")

# Test adaptive filter failures
expect_error(wbw_adaptive_filter(x, filter_size_x = 10L))
expect_error(wbw_adaptive_filter(x, filter_size_y = 2))
expect_error(wbw_adaptive_filter(x, filter_size_y = c(1:2)))
expect_error(wbw_adaptive_filter(x, filter_size_y = 1.5))
expect_error(wbw_adaptive_filter(x, threshold = "a"))
expect_error(wbw_adaptive_filter("x", threshold = "a"))

# Test bilateral filter failures
expect_error(wbw_bilateral_filter(x, sigma_dist = 10L))
expect_error(wbw_bilateral_filter(x, sigma_int = -2))
expect_error(wbw_bilateral_filter(x, sigma_dist = c(1:2)))
expect_error(wbw_bilateral_filter(x, sigma_dist = 20.1))
expect_error(wbw_bilateral_filter(x, sigma_dist = "a"))
expect_error(wbw_bilateral_filter("x", sigma_int = "a"))

# Test mean filter failures
expect_error(wbw_mean_filter(x, filter_size_x = 10L))
expect_error(wbw_mean_filter(x, filter_size_y = 2))
expect_error(wbw_mean_filter(x, filter_size_y = c(1:2)))
expect_error(wbw_mean_filter(x, filter_size_y = 1.5))
expect_error(wbw_mean_filter(x, filter_size_y = "a"))
expect_error(wbw_mean_filter("x", filter_size_y = "a"))

# Test conservative smoothing filter failures
expect_error(wbw_conservative_smoothing_filter(x, filter_size_x = 10L))
expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = 2))
expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = c(1:2)))
expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = 1.5))
expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = "a"))
expect_error(wbw_conservative_smoothing_filter("x", filter_size_y = "a"))

# Test high pass filter failures
expect_error(wbw_high_pass_filter(x, filter_size_x = 10, filter_size_y = 11))
expect_error(wbw_high_pass_filter(x, filter_size_x = 11, filter_size_y = 10))
expect_error(wbw_high_pass_filter(x, filter_size_x = 11.1, filter_size_y = 11))
expect_error(wbw_high_pass_filter("x", filter_size_x = 11, filter_size_y = 11))

# Test successful filter returns
expect_inherits(wbw_adaptive_filter(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_bilateral_filter(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_mean_filter(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_conservative_smoothing_filter(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_high_pass_filter(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_gaussian_filter(x), c("wbw::WhiteboxRaster", "S7_object"))

# Snapshots
expect_snapshot(
  label = "wbw_adaptive_filter",
  wbw_adaptive_filter(x)
)
expect_snapshot(
  label = "wbw_bilateral_filter",
  wbw_bilateral_filter(x)
)
expect_snapshot(
  label = "wbw_mean_filter",
  wbw_mean_filter(x)
)
expect_snapshot(
  label = "wbw_conservative_smoothing_filter",
  wbw_conservative_smoothing_filter(x)
)
expect_snapshot(
  label = "wbw_high_pass_filter",
  wbw_high_pass_filter(x)
)
expect_snapshot(
  label = "wbw_gaussian_filter",
  wbw_gaussian_filter(x)
)

# Test filter alterations
true_median <- median(x)

# Test adaptive filter
filtered <- wbw_adaptive_filter(x, filter_size_x = 51, filter_size_y = 51)
expect_true(median(filtered) != true_median)

# Test bilateral filter
filtered <- wbw_bilateral_filter(x, sigma_dist = 5, sigma_int = 5)
expect_true(median(filtered) != true_median)

# Test mean filter
filtered <- wbw_mean_filter(x, filter_size_x = 51, filter_size_y = 51)
expect_true(median(filtered) != true_median)

# Test gaussian filter
filtered <- wbw_gaussian_filter(x, sigma = 5)
expect_true(median(filtered) != true_median)
