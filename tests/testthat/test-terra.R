raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "WhiteboxRaster to SpatRaster conversion works",
  {
    # CRS has units of linear meters and data type is float
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
    # Data Type
    expect_identical(
      terra::is.int(r),
      terra::is.int(wbwr)
    )
    expect_identical(
      terra::is.bool(r),
      terra::is.bool(wbwr)
    )
    expect_identical(
      terra::is.factor(r),
      terra::is.factor(wbwr)
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


test_that(
  "WhiteboxRaster to SpatRaster conversion works with geographic CRS",
  {
    # CRS has units of degrees and data type is integer
    skip_if_not_installed("terra")
    f <- system.file("ex/elev.tif", package = "terra")
    r <- terra::rast(f)
    wbwr <- as_rast(wbw_read_raster(f))

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
    # Data Type
    expect_identical(
      terra::is.int(r),
      terra::is.int(wbwr)
    )
    expect_identical(
      terra::is.bool(r),
      terra::is.bool(wbwr)
    )
    expect_identical(
      terra::is.factor(r),
      terra::is.factor(wbwr)
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
