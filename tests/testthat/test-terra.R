source("../test-setup.R")

test_that("WhiteboxRaster to SpatRaster conversion works", {
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
})

test_that("WhiteboxRaster to SpatRaster conversion works with integer data", {
  skip_if_not_installed("terra")

  # Setup
  r <- terra::rast(f)
  r <- terra::as.int(r)
  wbwr <- wbw_read_raster(f)
  converted <- as_rast(wbwr)

  # Tests
  expect_true(terra::is.int(converted))
  expect_true(terra::is.int(r))
  expect_equal(as.vector(converted), as.vector(r))
})

test_that("WhiteboxRaster to SpatRaster conversion handles NA values", {
  skip_if_not_installed("terra")

  # Setup
  r <- terra::rast(f)
  r[r < mean(r[], na.rm = TRUE)] <- NA
  wbwr <- as_wbw_raster(r)
  converted <- as_rast(wbwr)

  # Tests
  expect_equal(sum(is.na(converted[])), sum(is.na(r[])))
  expect_equal(as.vector(converted), as.vector(r))
})

test_that("SpatRaster to WhiteboxRaster conversion handles different CRS", {
  skip_if_not_installed("terra")

  # Setup
  r <- terra::rast(f)
  r <- terra::project(r, "EPSG:4326")
  wbwr <- as_wbw_raster(r)
  converted <- as_rast(wbwr)

  # Tests
  expect_equal(terra::crs(converted), terra::crs(r))
  expect_equal(as.vector(converted), as.vector(r))
})

test_that("SpatRaster to WhiteboxRaster conversion validates inputs", {
  skip_if_not_installed("terra")

  # Test multilayer error
  r <- terra::rast(f)
  r2 <- c(r, r)
  expect_error(as_wbw_raster(r2), "nlyr.*1")

  # Test NA flag handling
  r_na <- terra::rast(f)
  terra::NAflag(r_na) <- NaN
  wbwr <- as_wbw_raster(r_na)
  expect_equal(wbwr@source$configs$nodata, -9999)
})

test_that("Conversion preserves raster properties", {
  skip_if_not_installed("terra")

  # Setup
  r <- terra::rast(f)
  wbwr <- as_wbw_raster(r)
  converted <- as_rast(wbwr)

  # Tests
  expect_equal(terra::res(converted), terra::res(r))
  expect_equal(as.vector(terra::ext(converted)), as.vector(terra::ext(r)))
  expect_equal(terra::ncol(converted), terra::ncol(r))
  expect_equal(terra::nrow(converted), terra::nrow(r))
  expect_equal(names(converted), names(r))
})

test_that("Conversion works with boolean and factor rasters", {
  skip_if_not_installed("terra")

  # Test boolean raster
  r <- terra::rast(f)
  r <- r > mean(r[], na.rm = TRUE)

  # TODO:
  # Configure boolean conversion from terra to wbw and back
  # wbwr <- as_wbw_raster(r)
  # converted <- as_rast(wbwr)
  # expect_equal(as.vector(converted), as.vector(r))

  # Test factor raster
  r_fact <- terra::as.factor(terra::classify(r, c(0, 1)))
  wbwr_fact <- as_wbw_raster(r_fact)
  converted_fact <- as_rast(wbwr_fact)
  expect_equal(as.vector(converted_fact), as.vector(r_fact))
})
