source("setup.R")

# Test as_matrix conversion
m <- as_matrix(x)
expect_true(is.matrix(m))
expect_equal(dim(m), c(726, 800))

# Test as_vector conversion
v <- as_vector(x)
expect_true(is.vector(v))
expect_equal(length(v), num_cells(x))

# Test summary stats for matrix
expect_equal(max(x), max(m, na.rm = TRUE))
expect_equal(min(x), min(m, na.rm = TRUE))
expect_equal(mean(x), mean(m, na.rm = TRUE))
expect_equal(round(median(x), 4), round(median(m, na.rm = TRUE), 4))
expect_equal(round(wbw::stdev(x), 4), round(sd(m, na.rm = TRUE), 4))

# Test summary stats for vector
expect_equal(max(x), max(v, na.rm = TRUE))
expect_equal(min(x), min(v, na.rm = TRUE))
expect_equal(mean(x), mean(v, na.rm = TRUE))
expect_equal(round(median(x), 4), round(median(v, na.rm = TRUE), 4))
expect_equal(round(wbw::stdev(x), 4), round(sd(v, na.rm = TRUE), 4))
expect_equal(round(variance(x), 1), round(var(v, na.rm = TRUE), 1))

# Test summary function output
s <- capture.output(summary(x))
expect_true(any(grepl("minimum", s)))
expect_true(any(grepl("maximum", s)))
expect_true(any(grepl("average", s)))
expect_true(any(grepl("standard deviation", s)))

# Test NoData handling
exit_if_not(requireNamespace("terra", quietly = TRUE))
r <- wbw_read_raster(f)

v <- as_vector(r)
v_raw <- as_vector(r, raw = TRUE)
m <- as_matrix(r)
m_raw <- as_matrix(r, raw = TRUE)

# Check dimensions
expect_equal(dim(m), dim(m_raw))
expect_equal(length(m), length(v_raw))

# Check NA values
expect_true(sum(is.na(m)) != 0)
expect_true(sum(is.na(m_raw)) == 0)
expect_true(sum(is.na(v)) != 0)
expect_true(sum(is.na(v_raw)) == 0)

# Test NA handling in summary stats
r <- wbw_read_raster(f)
expect_true(is.numeric(max(r)))
expect_true(is.numeric(min(r)))
expect_true(is.numeric(mean(r)))
expect_true(is.numeric(wbw::stdev(r)))
expect_true(is.numeric(median(r)))
expect_true(is.numeric(variance(r)))
