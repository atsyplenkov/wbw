library(wbw)

raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "geomorphometry fails",
  {
    # wbw_slope
    expect_error(wbw_slope(dem = mtcars))
    expect_error(wbw_slope(x, units = 1))
    expect_error(wbw_slope(x, units = "dg"))
    expect_error(wbw_slope(x, z_factor = 2L))

    # wbw_aspect
    expect_error(wbw_aspect(dem = mtcars))
    expect_error(wbw_aspect(x, z_factor = 2L))

    # wbw_ruggedness_index
    expect_error(wbw_ruggedness_index(dem = mtcars))
  }
)

test_that(
  "S7 object is returned",
  {
    expect_s7_class(
      wbw_slope(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_aspect(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_ruggedness_index(x),
      WhiteboxRaster
    )
  }
)
