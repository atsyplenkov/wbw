source("tests/tinytest/setup.R")
# source("setup.R")

# Test adaptive filter failures
# expect_error(wbw_adaptive_filter(x, filter_size_x = 10L))
# expect_error(wbw_adaptive_filter(x, filter_size_y = 2))
# expect_error(wbw_adaptive_filter(x, filter_size_y = c(1:2)))
# expect_error(wbw_adaptive_filter(x, filter_size_y = 1.5))
# expect_error(wbw_adaptive_filter(x, threshold = "a"))
# expect_error(wbw_adaptive_filter("x", threshold = "a"))

# # Test bilateral filter failures
# expect_error(wbw_bilateral_filter(x, sigma_dist = 10L))
# expect_error(wbw_bilateral_filter(x, sigma_int = -2))
# expect_error(wbw_bilateral_filter(x, sigma_dist = c(1:2)))
# expect_error(wbw_bilateral_filter(x, sigma_dist = 20.1))
# expect_error(wbw_bilateral_filter(x, sigma_dist = "a"))
# expect_error(wbw_bilateral_filter("x", sigma_int = "a"))

# # Test mean filter failures
# expect_error(wbw_mean_filter(x, filter_size_x = 10L))
# expect_error(wbw_mean_filter(x, filter_size_y = 2))
# expect_error(wbw_mean_filter(x, filter_size_y = c(1:2)))
# expect_error(wbw_mean_filter(x, filter_size_y = 1.5))
# expect_error(wbw_mean_filter(x, filter_size_y = "a"))
# expect_error(wbw_mean_filter("x", filter_size_y = "a"))

# # Test conservative smoothing filter failures
# expect_error(wbw_conservative_smoothing_filter(x, filter_size_x = 10L))
# expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = 2))
# expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = c(1:2)))
# expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = 1.5))
# expect_error(wbw_conservative_smoothing_filter(x, filter_size_y = "a"))
# expect_error(wbw_conservative_smoothing_filter("x", filter_size_y = "a"))

# # Test high pass filter failures
# expect_error(wbw_high_pass_filter(x, filter_size_x = 10, filter_size_y = 11))
# expect_error(wbw_high_pass_filter(x, filter_size_x = 11, filter_size_y = 10))
# expect_error(wbw_high_pass_filter(x, filter_size_x = 11.1, filter_size_y = 11))
# expect_error(wbw_high_pass_filter("x", filter_size_x = 11, filter_size_y = 11))

# # Test high pass median filter failures
# expect_error(wbw_high_pass_median_filter(x, filter_size_x = 10, filter_size_y = 11))
# expect_error(wbw_high_pass_median_filter(x, filter_size_x = 11, filter_size_y = 10))
# expect_error(wbw_high_pass_median_filter(x, filter_size_x = 11.1, filter_size_y = 11))
# expect_error(wbw_high_pass_median_filter("x", filter_size_x = 11, filter_size_y = 11))

# Test successful filter returns
expect_inherits(
  wbw_adaptive_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_bilateral_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_conservative_smoothing_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_gaussian_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_high_pass_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_high_pass_median_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_majority_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_maximum_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_mean_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_median_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_minimum_filter(x), c("wbw::WhiteboxRaster", "S7_object")
)


# Test filter alterations
# Here is near-equality check is happening. If two values are close to
# be equal, i.e. 2.222222226 and 2.222222225, then all.equal() returns TRUE
# In other cases the function will return the mean relative difference as
# a character vector
true_median <- median(x)

expect_true(
  wbw_adaptive_filter(
    x,
    filter_size_x = 51,
    filter_size_y = 51
  ) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_bilateral_filter(
    x,
    sigma_dist = 3
  ) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_conservative_smoothing_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_gaussian_filter(x, sigma = 1.5) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_high_pass_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_high_pass_median_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_majority_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_maximum_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_mean_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_median_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_minimum_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
