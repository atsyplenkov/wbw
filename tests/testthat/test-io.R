raster_path <-
  system.file("extdata/dem.tif", package = "wbw")
x <- wbw_read_raster(raster_path)

test_that(
  desc = "wbw_read function works",
  {
    # Is S7 object
    expect_s7_class(x, class = WhiteboxRaster)
  }
)

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
    expect_s7_class(wbw_read_raster(tmp_tiff),class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_sgrd),class = WhiteboxRaster)
    expect_s7_class(wbw_read_raster(tmp_sdat),class = WhiteboxRaster)
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
