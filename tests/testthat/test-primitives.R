raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

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
