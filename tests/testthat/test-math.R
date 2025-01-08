source('../test-setup.R')

test_that(
  "wbw_random_sample works",
  {
    expect_s7_class(
      wbw_random_sample(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_random_sample(x, num_samples = 1),
      WhiteboxRaster
    )
    # Errors
    expect_error(
      wbw_random_sample(x, num_samples = -1)
    )
    expect_error(
      wbw_random_sample(x, num_samples = runif(1))
    )
    expect_error(
      wbw_random_sample(x, num_samples = x@source$num_cells() + 1)
    )
  }
)
