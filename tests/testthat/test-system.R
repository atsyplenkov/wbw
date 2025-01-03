raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  "setting custom max_procs fails",
  {
    expect_error(wbw_max_procs(0))
    expect_error(wbw_max_procs(-20))
    expect_error(wbw_max_procs(1.1))
  }
)

test_that(
  "setting custom max_procs works",
  {
    wbw_max_procs(-1)
    t_parallel <- system.time(wbw_slope(x))

    wbw_max_procs(1)
    t_1 <- system.time(wbw_slope(x))

    expect_true(t_1[3] >= t_parallel[3])

  }
)

test_that("Sample data download works correctly", {
  skip_if_offline()  # Skip if no internet connection
  
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
  
  # Clean up
  unlink(file.path(temp_dir, "Grand_Junction"), recursive = TRUE)
})

