source("setup.R")

# Reading geotiff tags
expected_out <- c(
	"+-----------------------------------------------+ ",
	"| WhiteboxRaster                                |",
	"| dem.tif                                       |",
	"|...............................................| ",
	"| bands       : 1                               |",
	"| dimensions  : 726, 800  (nrow, ncol)          |",
	"| resolution  : 5.002392, 5.000243  (x, y)      |",
	"| EPSG        : 2193  (Linear_Meter)            |",
	"| extent      : 1925449 1929446 5582091 5585717 |",
	"| min value   : 63.698193                       |",
	"| max value   : 361.020721                      |",
	"+-----------------------------------------------+ "
)

expect_equal(
	paste(utils::capture.output(print(x)), collapse = "\n"),
	paste(expected_out, collapse = "\n")
)
