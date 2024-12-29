raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "WhiteboxRaster dimensions detected correctly",
  {
    skip_if_not_installed("terra")
    r <- terra::rast(raster_path)

    expect_equal(num_cells(x), terra::ncell(r))
    expect_equal(wbw_cols(x), terra::ncol(r))
    expect_equal(wbw_rows(x), terra::nrow(r))
    expect_equal(wbw_res(x), terra::res(r))
    expect_equal(wbw_yres(x), terra::yres(r))
    expect_equal(wbw_xres(x), terra::xres(r))

  }
)
