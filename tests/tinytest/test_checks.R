source("setup.R")

# Package checks
expect_silent(wbw:::check_package("base"))
expect_error(wbw:::check_package("nonexistentpackage123"))

# Environment checks
mock_env <- structure(
  list(),
  class = c(
    "whitebox_workflows.WbEnvironment",
    "python.builtin.WbEnvironmentBase",
    "python.builtin.object"
  )
)

expect_silent(wbw:::check_env(mock_env))
expect_error(wbw:::check_env(list()))
expect_error(wbw:::check_env(NULL))

# Vector file checks
temp_shp <- tempfile(fileext = ".shp")
file.create(temp_shp)

expect_silent(wbw:::check_input_file(temp_shp, "vector"))
expect_error(wbw:::check_input_file("nonexistent.shp", "vector"))

temp_wrong <- tempfile(fileext = ".txt")
file.create(temp_wrong)
expect_error(wbw:::check_input_file(temp_wrong, "vector"))

# Raster file checks
temp_tif <- tempfile(fileext = ".tif")
file.create(temp_tif)

expect_silent(wbw:::check_input_file(temp_tif, "raster"))
expect_error(wbw:::check_input_file("nonexistent.tif", "raster"))

temp_wrong <- tempfile(fileext = ".txt")
file.create(temp_wrong)
expect_error(wbw:::check_input_file(temp_wrong, "raster"))

# Type validation
expect_error(wbw:::check_input_file(temp_file, "invalid_type"))

# Cleanup
unlink(temp_shp)
unlink(temp_wrong)
unlink(temp_tif)
