source("../test-setup.R")

test_that("WhiteboxExtent recognized correctly", {
  # Test the extent extraction
  ext <- wbw_ext(x)
  expect_s7_class(ext, WhiteboxExtent)
  expect_snapshot(ext)

  # Test individual components
  expect_identical(ext@west, x@source$configs$west)
  expect_identical(ext@east, x@source$configs$east)
  expect_identical(ext@south, x@source$configs$south)
  expect_identical(ext@north, x@source$configs$north)

  # Test error cases
  expect_error(wbw_ext("x"), class = "S7_error_method_not_found")
  expect_error(wbw_ext(NULL), class = "S7_error_method_not_found")
})
