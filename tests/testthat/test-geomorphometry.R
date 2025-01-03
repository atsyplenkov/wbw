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
    expect_error(wbw_slope(NULL))

    # wbw_aspect
    expect_error(wbw_aspect(dem = mtcars))
    expect_error(wbw_aspect(x, z_factor = 2L))
    expect_error(wbw_aspect(NULL))

    # wbw_ruggedness_index
    expect_error(wbw_ruggedness_index(dem = mtcars))
    expect_error(wbw_ruggedness_index(1:10))
    expect_error(wbw_ruggedness_index(NULL))

    # wbw_fill_missing_data
    expect_error(wbw_fill_missing_data(x = mtcars))
    expect_error(wbw_fill_missing_data(x, filter_size = 2.5))
    expect_error(wbw_fill_missing_data(x, weight = "2.5"))
    expect_error(wbw_fill_missing_data(x, exclude_edge_nodata = "YES"))
    expect_error(wbw_fill_missing_data(NULL))
  }
)

test_that(
  "S7 object is returned",
  {
    # wbw_slope
    expect_s7_class(
      wbw_slope(x, units = "degrees"),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_slope(x, units = "radians"),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_slope(x, units = "percent"),
      WhiteboxRaster
    )

    # wbw_aspect
    expect_s7_class(
      wbw_aspect(x),
      WhiteboxRaster
    )
    expect_s7_class(
      wbw_aspect(x, z_factor = 3.1),
      WhiteboxRaster
    )

    # wbw_ruggedness_index
    expect_s7_class(
      wbw_ruggedness_index(x),
      WhiteboxRaster
    )
    
    # wbw_fill_missing_data
    expect_s7_class(
      wbw_fill_missing_data(x),
      WhiteboxRaster
    )
  }
)

test_that(
  "Sample data download works correctly and fill missing data works",
  {
    skip_if_offline() # Skip if no internet connection

    # Use temp directory for testing
    temp_dir <- tempdir()

    # Download Grand Junction dataset
    test_path <- wbw_download_sample_data(
      data_set = "Grand_Junction",
      path = temp_dir
    )

    # Check if download was successful
    expect_true(dir.exists(test_path))

    # Check if DEM file exists
    dem_path <- file.path(test_path, "DEM.tif")
    expect_true(file.exists(dem_path))

    # Read DEM and check its class
    dem <- wbw_read_raster(dem_path)
    expect_s7_class(dem, WhiteboxRaster)

    # Fill missing data
    dem_filled <- wbw_fill_missing_data(dem)
    expect_s7_class(dem_filled, WhiteboxRaster)

    # Check if fill missing data worked
    m <- as_matrix(dem)
    m_filled <- as_matrix(dem_filled)
    expect_true(sum(is.na(m_filled)) <= sum(is.na(m)))

    # Clean up
    unlink(file.path(temp_dir, "Grand_Junction"), recursive = TRUE)
  }
)
