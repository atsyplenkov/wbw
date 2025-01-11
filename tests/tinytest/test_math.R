source("setup.R")

# Test random sample generation
expect_inherits(wbw_random_sample(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(
	wbw_random_sample(x, num_samples = 1),
	c("wbw::WhiteboxRaster", "S7_object")
)

# Test error conditions
expect_error(wbw_random_sample(x, num_samples = -1))
expect_error(wbw_random_sample(x, num_samples = runif(1)))
expect_error(wbw_random_sample(x, num_samples = x@source$num_cells() + 1))
