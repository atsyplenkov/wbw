raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "WhiteboxRaster to SpatRaster conversion works",
  {
    skip_if_not_installed("terra")
    r <- terra::rast(raster_path)
    wbwr <- as_rast(x)

    # Extent
    expect_identical(
      as.vector(terra::ext(r)),
      as.vector(terra::ext(wbwr))
    )
    # Content
    expect_identical(
      as.vector(r),
      as.vector(wbwr)
    )
    # Resolution
    expect_identical(
      terra::res(r),
      terra::res(wbwr)
    )
    # CRS
    expect_identical(
      terra::crs(r),
      terra::crs(wbwr)
    )
  }
)
