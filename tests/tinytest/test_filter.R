source("setup.R")

# Test successful filter returns
expect_inherits(
  wbw_adaptive_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_bilateral_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_conservative_smoothing_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_gaussian_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_high_pass_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_high_pass_median_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_majority_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_maximum_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_mean_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_median_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_minimum_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_olympic_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_percentile_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_range_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_total_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_standard_deviation_filter(x),
  c("wbw::WhiteboxRaster", "S7_object")
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
expect_true(
  wbw_olympic_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_percentile_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_range_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_total_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_standard_deviation_filter(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
