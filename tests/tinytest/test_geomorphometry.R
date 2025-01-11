source("setup.R")

# Test slope failures
expect_error(wbw_slope(dem = mtcars))
expect_error(wbw_slope(x, units = 1))
expect_error(wbw_slope(x, units = "dg"))
expect_error(wbw_slope(x, z_factor = 2L))
expect_error(wbw_slope(NULL))

# Test aspect failures
expect_error(wbw_aspect(dem = mtcars))
expect_error(wbw_aspect(x, z_factor = 2L))
expect_error(wbw_aspect(NULL))

# Test ruggedness index failures
expect_error(wbw_ruggedness_index(dem = mtcars))
expect_error(wbw_ruggedness_index(1:10))
expect_error(wbw_ruggedness_index(NULL))

# Test fill missing data failures
expect_error(wbw_fill_missing_data(x = mtcars))
expect_error(wbw_fill_missing_data(x, filter_size = 2.5))
expect_error(wbw_fill_missing_data(x, weight = "2.5"))
expect_error(wbw_fill_missing_data(x, exclude_edge_nodata = "YES"))
expect_error(wbw_fill_missing_data(NULL))

# Test successful returns
expect_inherits(wbw_aspect(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_slope(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_ruggedness_index(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(wbw_fill_missing_data(x), c("wbw::WhiteboxRaster", "S7_object"))
expect_inherits(
	wbw_multidirectional_hillshade(x),
	c("wbw::WhiteboxRaster", "S7_object")
)
expect_inherits(wbw_hillshade(x), c("wbw::WhiteboxRaster", "S7_object"))

# Test sample data download and fill missing data
temp_dir <- tempdir()
test_path <- wbw_download_sample_data(
	data_set = "Grand_Junction",
	path = temp_dir
)

expect_true(dir.exists(test_path))
dem_path <- file.path(test_path, "DEM.tif")
expect_true(file.exists(dem_path))

dem <- wbw_read_raster(dem_path)
expect_inherits(dem, c("wbw::WhiteboxRaster", "S7_object"))

dem_filled <- wbw_fill_missing_data(dem)
expect_inherits(dem_filled, c("wbw::WhiteboxRaster", "S7_object"))

# Check if fill missing data worked
m <- as_matrix(dem)
m_filled <- as_matrix(dem_filled)
expect_true(sum(is.na(m_filled)) <= sum(is.na(m)))

# Clean up
unlink(file.path(temp_dir, "Grand_Junction"), recursive = TRUE)
