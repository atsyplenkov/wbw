raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "conversion to radians works",
  {
    slope_deg <- wbw_slope(x, units = "d")
    slope_rad <- wbw_slope(x, units = "r")
    deg_to_rad <- wbw_to_radians(slope_deg)
    rad_to_deg <- wbw_to_degrees(slope_rad)

    expect_s7_class(
      deg_to_rad,
      WhiteboxRaster
    )
    expect_s7_class(
      rad_to_deg,
      WhiteboxRaster
    )
    expect_equal(
      mean(slope_rad),
      mean(deg_to_rad)
    )
    expect_equal(
      mean(slope_deg),
      mean(rad_to_deg)
    )
  }
)
