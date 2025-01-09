library(tinytest)
library(wbw)

# Load New Zealand DEM
raster_path <- system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

# Path to terra's files
if (requireNamespace("terra", quietly = TRUE)) {
  library(terra)
  f <- system.file("ex/elev.tif", package = "terra")
} 

# Helper functions
skip_if_not_installed <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    exit_file("Package", pkg, "not available")
  }
}
