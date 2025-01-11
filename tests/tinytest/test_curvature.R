source("setup.R")

# Test successful filter returns
expect_inherits(
  wbw_gaussian_curvature(x),
  c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(
  wbw_maximal_curvature(x),
  c("wbw::WhiteboxRaster", "S7_object")
)

# Test curvature alterations
# Here is near-equality check is happening. If two values are close to
# be equal, i.e. 2.222222226 and 2.222222225, then all.equal() returns TRUE
# In other cases the function will return the mean relative difference as
# a character vector
true_median <- median(x)

expect_true(
  wbw_gaussian_curvature(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_gaussian_curvature(x, log_transform = TRUE) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_maximal_curvature(x) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
expect_true(
  wbw_maximal_curvature(x, log_transform = TRUE) |>
    median() |>
    all.equal(true_median) |>
    is.character()
)
