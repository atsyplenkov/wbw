library(wbw)

# Load New Zealand DEM
raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

# Path to terra's files
# f <- system.file("ex/elev.tif", package = "terra")
if (requireNamespace("terra", quietly = TRUE)) {
  library(terra)
  f <- system.file("ex/elev.tif", package = "terra")
}
