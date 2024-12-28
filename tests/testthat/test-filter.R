raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "filter fails",
  {
    expect_error(
      wbw_adaptive_filter(x, filter_size_x = 10L)
    )
    expect_error(
      wbw_adaptive_filter(x, filter_size_y = 2L)
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
  }
)

test_that(
  "filter returns WhiteboxRaster",
  {
    expect_s7_class(
      wbw_adaptive_filter(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_adaptive_filter(x, filter_size_x = 3L, filter_size_y = 3L),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_adaptive_filter(x, threshold = 5),
      WhiteboxRaster
    )
  }
)
