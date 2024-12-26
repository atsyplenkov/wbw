test_that(
  desc = "wbw_read function works",
  {
    raster_path <-
      system.file("extdata/dem.tif", package = "wbw")
    x <- wbw_read_raster(raster_path)

    # Is S7 object
    expect_true(inherits(x, "S7_object"))
    expect_null(S7::check_is_S7(x))
  }
)


