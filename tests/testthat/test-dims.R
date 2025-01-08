source('../test-setup.R')

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

test_that(
  "WhiteboxRaster data types detected correctly",
  {
    skip_if_not_installed("terra")
    r <- terra::rast(raster_path)

    f <- system.file("ex/elev.tif", package = "terra")
    r2 <- terra::rast(f)
    x2 <- wbw_read_raster(f)

    # Compare with {terra}
    expect_equal(wbw_is_int(x), terra::is.int(r))
    expect_equal(wbw_is_int(x2), terra::is.int(r2))
    expect_equal(wbw_data_type(x2), "RasterDataType.I16")
    expect_equal(wbw_data_type(x), "RasterDataType.F32")

    # Check output class
    expect_type(wbw_is_int(x), "logical")
    expect_type(wbw_is_float(x), "logical")
    expect_type(wbw_is_rgb(x), "logical")
    expect_type(wbw_data_type(x), "character")

    # Check input object
    expect_error(wbw_is_int(r))
    expect_error(wbw_is_float(r))
    expect_error(wbw_is_rgb(r))
    expect_error(wbw_data_type(r))
  }
)
