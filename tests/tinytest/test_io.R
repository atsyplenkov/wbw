source("setup.R")

# Helper function
create_temp_file <- function(ext) {
	tmp <- tempfile(fileext = ext)
	file.create(tmp)
	return(tmp)
}

# Test wbw_read_raster
expect_inherits(
	wbw_read_raster(raster_path),
	c("wbw::WhiteboxRaster", "S7_object")
)
expect_error(wbw_read_raster("nonexistent.tif"))

tmp_txt <- create_temp_file(".txt")
on.exit(unlink(tmp_txt))
expect_error(wbw_read_raster(tmp_txt))

tmp_shp <- create_temp_file(".shp")
on.exit(unlink(tmp_shp), add = TRUE)
expect_error(wbw_read_vector("nonexistent.shp"))
expect_error(wbw_read_vector(tmp_txt))

# Test wbw_write_raster
expect_error(wbw_write_raster(mtcars, file_name = tempfile(fileext = ".tif")))

# Test geotiff compression
tmp_tif_c <- tempfile(fileext = ".tif")
tmp_tiff_c <- tempfile(fileext = ".tiff")
tmp_tif <- tempfile(fileext = ".tif")
tmp_tiff <- tempfile(fileext = ".tiff")
on.exit(
	{
		unlink(tmp_tif_c)
		unlink(tmp_tiff_c)
		unlink(tmp_tif)
		unlink(tmp_tiff)
	},
	add = TRUE
)

wbw_write_raster(x, file_name = tmp_tif_c, compress = TRUE)
wbw_write_raster(x, file_name = tmp_tiff_c, compress = TRUE)
wbw_write_raster(x, file_name = tmp_tif, compress = FALSE)
wbw_write_raster(x, file_name = tmp_tiff, compress = FALSE)

expect_true(file.size(tmp_tif_c) < file.size(tmp_tif))
expect_true(file.size(tmp_tiff_c) < file.size(tmp_tiff))

# Test different raster formats
formats <- c(
	".tif",
	".tiff",
	".sgrd",
	".sdat",
	".rst",
	".rdc",
	".bil",
	".flt",
	".grd"
)
temp_files <- vapply(formats, create_temp_file, character(1))
on.exit(unlink(temp_files), add = TRUE)

for (file in temp_files) {
	wbw_write_raster(x, file_name = file)
	expect_true(file.exists(file))
	expect_inherits(wbw_read_raster(file), c("wbw::WhiteboxRaster", "S7_object"))
}
