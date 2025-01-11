# Test rd_wbw_link function
expected <- paste0(
	"@references For more information, see ",
	"<https://www.whiteboxgeo.com/manual",
	"/wbw-user-manual/book/tool_help.html#",
	"slope>"
)
expect_equal(wbw:::rd_wbw_link("slope"), expected)

# Test with underscores
expected <- paste0(
	"@references For more information, see ",
	"<https://www.whiteboxgeo.com/manual",
	"/wbw-user-manual/book/tool_help.html#",
	"breach_depressions>"
)
expect_equal(wbw:::rd_wbw_link("breach_depressions"), expected)

# Test rd_input_raster function
expected <- paste0(
	"@param dem Raster object of class [WhiteboxRaster]. ",
	"See [wbw_read_raster()] for more details."
)
expect_equal(wbw:::rd_input_raster("dem"), expected)

# Test rd_example function
expected <- paste(
	"@examples",
	'f <- system.file("extdata/dem.tif", package = "wbw")',
	"wbw_read_raster(f) |>",
	"  slope()",
	sep = "\n"
)
expect_equal(wbw:::rd_example("slope"), expected)

# Test with arguments
expected <- paste(
	"@examples",
	'f <- system.file("extdata/dem.tif", package = "wbw")',
	"wbw_read_raster(f) |>",
	"  slope(units = 'degrees')",
	sep = "\n"
)
expect_equal(wbw:::rd_example("slope", "units = 'degrees'"), expected)

# Test error cases
expect_error(wbw:::rd_wbw_link(""))
expect_error(wbw:::rd_input_raster(""))
expect_error(wbw:::rd_example(""))
expect_error(wbw:::rd_wbw_link(NULL))
expect_error(wbw:::rd_input_raster(NULL))
expect_error(wbw:::rd_example(NULL))
