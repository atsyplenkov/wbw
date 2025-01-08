source('../test-setup.R')

test_that(
  "as_matrix converts WhiteboxRaster to matrix",
  {
    m <- as_matrix(x)

    expect_true(is.matrix(m))
    expect_equal(dim(m), c(726, 800))
  }
)

test_that(
  "as_vector converts WhiteboxRaster to vector",
  {
    v <- as_vector(x)

    expect_true(is.vector(v))
    expect_equal(length(v), num_cells(x))
  }
)

test_that(
  "as_vector and as_matrix can convert NoData value to NA",
  {
    skip_if_not_installed("terra")
    f <- system.file("ex/elev.tif", package="terra")
    r <- wbw_read_raster(f)

    v <- as_vector(r)
    v_raw <- as_vector(r, raw = TRUE)

    m <- as_matrix(r)
    m_raw <- as_matrix(r, raw = TRUE)

    # Check dims
    expect_equal(dim(m), dim(m_raw))
    expect_equal(length(m), length(v_raw))

    # Check NA values
    expect_true(sum(is.na(m)) != 0) 
    expect_true(sum(is.na(m_raw)) == 0) 
    expect_true(sum(is.na(v)) != 0) 
    expect_true(sum(is.na(v_raw)) == 0) 

  }
)

test_that(
  "summary stats are true",
  {
    m <- as_matrix(x)

    expect_equal(max(x), max(m))
    expect_equal(min(x), min(m))
    expect_equal(mean(x), mean(m))
    expect_equal(round(median(x), 4), round(median(m), 4))
    expect_equal(round(stdev(x), 4), round(sd(m), 4))
    expect_equal(round(variance(x), 1), round(var(as.vector(m)), 1))
  }
)

test_that("summary function works correctly", {
  
  # Test summary output
  expect_output(summary(x), "minimum")
  expect_output(summary(x), "maximum")
  expect_output(summary(x), "average")
  expect_output(summary(x), "standard deviation")
})

test_that("summary stats handle edge cases", {
  
  # Test error cases with invalid raster
  expect_error(max(invalid_raster))
  expect_error(min(invalid_raster))
  expect_error(median(invalid_raster))
  expect_error(mean(invalid_raster))
  expect_error(stdev(invalid_raster))
  expect_error(variance(invalid_raster))
  
  # Test with raster containing NA values
  skip_if_not_installed("terra")
  f <- system.file("ex/elev.tif", package="terra")
  r <- wbw_read_raster(f)
  
  # Test that summary stats handle NA values
  expect_no_error(max(r))
  expect_no_error(min(r))
  expect_no_error(mean(r))
  expect_no_error(median(r))
  expect_no_error(stdev(r))
  expect_no_error(variance(r))
})

test_that("summary stats are consistent with matrix calculations", {
  
  m <- as_matrix(x)
  v <- as.vector(m)
  
  # More precise testing of summary statistics
  expect_equal(max(x), max(m, na.rm = TRUE))
  expect_equal(min(x), min(m, na.rm = TRUE))
  expect_equal(mean(x), mean(m, na.rm = TRUE))
  expect_equal(median(x), median(v, na.rm = TRUE), tolerance = 1e-5)
  expect_equal(stdev(x), sd(v, na.rm = TRUE), tolerance = 1e-5)
  expect_equal(variance(x), var(v, na.rm = TRUE), tolerance = 1e-5)
})
