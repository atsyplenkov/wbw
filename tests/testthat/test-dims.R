raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "WhiteboxRaster dimensions detected correctly",
  {
    skip_if_not_installed("terra")
    r <- terra::rast(raster_path)

    expect_equal(ncell(x), terra::ncell(r))
    expect_equal(ncol(x), terra::ncol(r))
    expect_equal(nrow(x), terra::nrow(r))
    expect_equal(res(x), terra::res(r))
    expect_equal(yres(x), terra::yres(r))
    expect_equal(xres(x), terra::xres(r))

  }
)
