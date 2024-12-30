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

    # Conversion worked, but crs objects are not identical
    x@source$configs$epsg_code <- 0L
    wbwr <- as_rast(x)
    expect_false(
      identical(
        terra::crs(r),
        terra::crs(wbwr)
      )
    )
  }
)
