test_that("check_package works", {
  # Should not error for installed packages
  expect_no_error(check_package("base"))
  
  # Should error for non-installed packages
  expect_error(
    check_package("nonexistentpackage123"),
    "nonexistentpackage123 is required but not installed"
  )
})

test_that("check_env works", {
  # Mock a whitebox environment object
  mock_env <- structure(
    list(),
    class = c(
      "whitebox_workflows.WbEnvironment",
      "python.builtin.WbEnvironmentBase",
      "python.builtin.object"
    )
  )
  
  # Should not error with correct environment
  expect_no_error(check_env(mock_env))
  
  # Should error with incorrect environment
  expect_error(check_env(list()))
  expect_error(check_env(NULL))
})

test_that("check_input_file works for vector files", {
  # Create temporary shapefile for testing
  temp_shp <- tempfile(fileext = ".shp")
  file.create(temp_shp)
  on.exit(unlink(temp_shp))
  
  # Test vector file checks
  expect_no_error(check_input_file(temp_shp, "vector"))
  
  # Should error with non-existent file
  expect_error(
    check_input_file("nonexistent.shp", "vector"),
    "Assertion on 'file_name' failed: File does not exist: 'nonexistent.shp'"
  )
  
  # Should error with wrong extension
  temp_wrong <- tempfile(fileext = ".txt")
  file.create(temp_wrong)
  on.exit(unlink(temp_wrong), add = TRUE)
  
  expect_error(
    check_input_file(temp_wrong, "vector")
  )
})

test_that("check_input_file works for raster files", {
  # Create temporary raster file for testing
  temp_tif <- tempfile(fileext = ".tif")
  file.create(temp_tif)
  on.exit(unlink(temp_tif))
  
  # Test raster file checks
  expect_no_error(check_input_file(temp_tif, "raster"))
  
  # Should error with non-existent file
  expect_error(
    check_input_file("nonexistent.tif", "raster"),
    "Assertion on 'file_name' failed: File does not exist: 'nonexistent.tif'"
  )
  
  # Should error with wrong extension
  temp_wrong <- tempfile(fileext = ".txt")
  file.create(temp_wrong)
  on.exit(unlink(temp_wrong), add = TRUE)
  
  expect_error(
    check_input_file(temp_wrong, "raster")
  )
})

test_that("check_input_file validates type argument", {
  temp_file <- tempfile(fileext = ".tif")
  file.create(temp_file)
  on.exit(unlink(temp_file))
  
  # Should error with invalid type
  expect_error(
    check_input_file(temp_file, "invalid_type")
  )
})

test_that("check_env works with wbe environment", {
  skip_if_no_wbw()
  
  # Test with actual wbe environment
  expect_no_error(check_env(wbe))
  
})
