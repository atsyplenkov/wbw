source("setup.R")

# Test extent extraction
ext <- wbw_ext(x)
expect_inherits(ext, c("wbw::WhiteboxExtent", "S7_object"))

# Test individual components
expect_identical(ext@west, x@source$configs$west)
expect_identical(ext@east, x@source$configs$east)
expect_identical(ext@south, x@source$configs$south)
expect_identical(ext@north, x@source$configs$north)

# Test error cases
expect_error(wbw_ext("x"))
expect_error(wbw_ext(NULL)) 