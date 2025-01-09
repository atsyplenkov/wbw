source("setup.R")

skip_if_not_installed("terra")

# Test WhiteboxRaster to SpatRaster conversion
r <- terra::rast(raster_path)
wbwr <- as_rast(x)

# Test extent
expect_identical(
  as.vector(terra::ext(r)),
  as.vector(terra::ext(wbwr))
)

# Test content
expect_identical(
  as.vector(r),
  as.vector(wbwr)
)

# Test resolution
expect_identical(
  terra::res(r),
  terra::res(wbwr)
)

# Test CRS
expect_identical(
  terra::crs(r),
  terra::crs(wbwr)
)

# Test data type
expect_identical(
  terra::is.int(r),
  terra::is.int(wbwr)
)

# Test integer data
r <- terra::rast(f)
r <- terra::as.int(r)
wbwr <- wbw_read_raster(f)
converted <- as_rast(wbwr)

expect_true(terra::is.int(converted))
expect_true(terra::is.int(r))
expect_equal(as.vector(converted), as.vector(r))

# Test NA handling
r <- terra::rast(f)
r[r < mean(r[], na.rm = TRUE)] <- NA
wbwr <- as_wbw_raster(r)
converted <- as_rast(wbwr)

expect_equal(sum(is.na(converted[])), sum(is.na(r[])))
expect_equal(as.vector(converted), as.vector(r))

# Test CRS conversion
r <- terra::rast(f)
r <- terra::project(r, "EPSG:4326")
wbwr <- as_wbw_raster(r)
converted <- as_rast(wbwr)

expect_equal(terra::crs(converted), terra::crs(r))
expect_equal(as.vector(converted), as.vector(r))

# Test multilayer error
r <- terra::rast(f)
r2 <- c(r, r)
expect_error(as_wbw_raster(r2))
