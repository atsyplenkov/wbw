library(wbw)

raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)
m <- as.matrix(x)

test_that(
  "as.matrix converts WhiteboxRaster to matrix",
  {
    expect_true(is.matrix(m))
    expect_equal(dim(m), c(726, 800))
  }
)

test_that(
  "summary stats are true",
  {
    expect_equal(max(x), max(m))
    expect_equal(min(x), min(m))
    expect_equal(mean(x), mean(m))
  }
)
