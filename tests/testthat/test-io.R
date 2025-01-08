source("../test-setup.R")

# Helper function to create temporary files
create_temp_file <- function(ext) {
  tmp <- tempfile(fileext = ext)
  file.create(tmp)
  return(tmp)
}

test_that(
  desc = "wbw_read function works",
  {
    expect_s7_class(wbw_read_raster(raster_path), class = WhiteboxRaster)

    # Test error on non-existent file
    expect_error(
      wbw_read_raster("nonexistent.tif"),
      "File does not exist"
    )

    # Test error on wrong file type
    tmp_txt <- create_temp_file(".txt")
    on.exit(unlink(tmp_txt))
    expect_error(
      wbw_read_raster(tmp_txt),
      "File extension"
    )
  }
)

test_that("wbw_read_vector function works", {
  skip_if_no_wbw()

  # Create temporary shapefile
  tmp_shp <- create_temp_file(".shp")
  on.exit(unlink(tmp_shp))

  # Test error on non-existent file
  expect_error(
    wbw_read_vector("nonexistent.shp"),
    "File does not exist"
  )

  # Test error on wrong file type
  tmp_txt <- create_temp_file(".txt")
  on.exit(unlink(tmp_txt), add = TRUE)
  expect_error(
    wbw_read_vector(tmp_txt),
    "File extension"
  )
})

test_that(
  desc = "wbw_write works only with Wbw* objects",
  {
    expect_error(
      wbw_write_raster(mtcars, file_name = tempfile(fileext = ".tif"))
    )
  }
)

test_that(
  desc = "geotiff compression works",
  {
    # Compressed
    tmp_tif_c <- tempfile(fileext = ".tif")
    tmp_tiff_c <- tempfile(fileext = ".tiff")

    # Uncompressed
    tmp_tif <- tempfile(fileext = ".tif")
    tmp_tiff <- tempfile(fileext = ".tiff")

    # Write files
    wbw_write_raster(x, file_name = tmp_tif_c, compress = TRUE)
    wbw_write_raster(x, file_name = tmp_tiff_c, compress = TRUE)
    wbw_write_raster(x, file_name = tmp_tif, compress = FALSE)
    wbw_write_raster(x, file_name = tmp_tiff, compress = FALSE)

    # Checks
    expect_true(
      file.size(tmp_tif_c) < file.size(tmp_tif)
    )
    expect_true(
      file.size(tmp_tiff_c) < file.size(tmp_tiff)
    )

    # Cleanup
    try(file.remove(tmp_tif), silent = TRUE)
    try(file.remove(tmp_tiff), silent = TRUE)
    try(file.remove(tmp_tif_c), silent = TRUE)
    try(file.remove(tmp_tiff_c), silent = TRUE)
  }
)

test_that("geotiff compression works", {
  # Create temporary files
  tmp_tif_c <- tempfile(fileext = ".tif")
  tmp_tiff_c <- tempfile(fileext = ".tiff")
  tmp_tif <- tempfile(fileext = ".tif")
  tmp_tiff <- tempfile(fileext = ".tiff")
  on.exit({
    unlink(tmp_tif_c)
    unlink(tmp_tiff_c)
    unlink(tmp_tif)
    unlink(tmp_tiff)
  })

  # Write files with and without compression
  wbw_write_raster(x, file_name = tmp_tif_c, compress = TRUE)
  wbw_write_raster(x, file_name = tmp_tiff_c, compress = TRUE)
  wbw_write_raster(x, file_name = tmp_tif, compress = FALSE)
  wbw_write_raster(x, file_name = tmp_tiff, compress = FALSE)

  # Test file sizes
  expect_true(file.size(tmp_tif_c) < file.size(tmp_tif))
  expect_true(file.size(tmp_tiff_c) < file.size(tmp_tiff))
})


test_that(
  desc = "raster objects can be saved on disk",
  {
    # Save as
    tmp_tif <- tempfile(fileext = ".tif")
    tmp_tiff <- tempfile(fileext = ".tiff")
    tmp_sgrd <- tempfile(fileext = ".sgrd")
    tmp_sdat <- tempfile(fileext = ".sdat")
    tmp_rst <- tempfile(fileext = ".rst")
    tmp_rdc <- tempfile(fileext = ".rdc")
    tmp_bil <- tempfile(fileext = ".bil")
    tmp_flt <- tempfile(fileext = ".flt")
    tmp_grd <- tempfile(fileext = ".grd")

    # Write files
    wbw_write_raster(x, file_name = tmp_tif)
    wbw_write_raster(x, file_name = tmp_tiff)
    wbw_write_raster(x, file_name = tmp_sgrd)
    wbw_write_raster(x, file_name = tmp_sdat)
    wbw_write_raster(x, file_name = tmp_rst)
    wbw_write_raster(x, file_name = tmp_rdc)
    wbw_write_raster(x, file_name = tmp_bil)
    wbw_write_raster(x, file_name = tmp_flt)
    wbw_write_raster(x, file_name = tmp_grd)

    # Check if file exists
    expect_true(file.exists(tmp_tif))
    expect_true(file.exists(tmp_tiff))
    expect_true(file.exists(tmp_sgrd))
    expect_true(file.exists(tmp_sdat))
    expect_true(file.exists(tmp_rst))
    expect_true(file.exists(tmp_rdc))
    expect_true(file.exists(tmp_bil))
    expect_true(file.exists(tmp_flt))
    expect_true(file.exists(tmp_grd))

    # Check if files can be read back into R session
    expect_s7_class(wbw_read_raster(tmp_tif), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_tiff), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_sgrd), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_sdat), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_rst), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_rdc), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_bil), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_flt), class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_grd), class = WhiteboxRaster)

    # Clean up
    try(file.remove(tmp_tif), silent = TRUE)
    try(file.remove(tmp_tiff), silent = TRUE)
    try(file.remove(tmp_sgrd), silent = TRUE)
    try(file.remove(tmp_sdat), silent = TRUE)
    try(file.remove(tmp_rst), silent = TRUE)
    try(file.remove(tmp_rdc), silent = TRUE)
    try(file.remove(tmp_bil), silent = TRUE)
    try(file.remove(tmp_flt), silent = TRUE)
    try(file.remove(tmp_grd), silent = TRUE)
  }
)

test_that("raster objects can be saved in different formats", {
  # Create temporary files with different extensions
  extensions <- c(
    ".tif", ".tiff", ".sgrd", ".sdat", ".rst",
    ".rdc", ".bil", ".flt", ".grd"
  )
  temp_files <- vapply(
    extensions,
    \(x) tempfile(fileext = x),
    FUN.VALUE = character(1)
  )
  on.exit(vapply(temp_files, unlink, FUN.VALUE = integer(1)))

  # Write and test each format
  for (file in temp_files) {
    # Write file
    wbw_write_raster(x, file_name = file)

    # Check if file exists
    expect_true(file.exists(file))

    # Check if file can be read back
    expect_s7_class(wbw_read_raster(file), class = WhiteboxRaster)
  }
})
