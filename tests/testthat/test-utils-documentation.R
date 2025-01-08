test_that("rd_wbw_link creates correct reference links", {
  # Test basic function name
  expected <- paste0(
    "@references For more information, see ",
    "<https://www.whiteboxgeo.com/manual",
    "/wbw-user-manual/book/tool_help.html#",
    "slope>"
  )
  expect_equal(rd_wbw_link("slope"), expected)
  
  # Test function name with underscores
  expected <- paste0(
    "@references For more information, see ",
    "<https://www.whiteboxgeo.com/manual",
    "/wbw-user-manual/book/tool_help.html#",
    "breach_depressions>"
  )
  expect_equal(rd_wbw_link("breach_depressions"), expected)
  
  # Test function name with numbers
  expected <- paste0(
    "@references For more information, see ",
    "<https://www.whiteboxgeo.com/manual",
    "/wbw-user-manual/book/tool_help.html#",
    "d8_flow_accumulation>"
  )
  expect_equal(rd_wbw_link("d8_flow_accumulation"), expected)
})

test_that("rd_input_raster creates correct parameter documentation", {
  # Test basic parameter name
  expected <- paste0(
    "@param dem Raster object of class [WhiteboxRaster]. ",
    "See [wbw_read_raster()] for more details."
  )
  expect_equal(rd_input_raster("dem"), expected)
  
  # Test parameter name with underscore
  expected <- paste0(
    "@param flow_acc Raster object of class [WhiteboxRaster]. ",
    "See [wbw_read_raster()] for more details."
  )
  expect_equal(rd_input_raster("flow_acc"), expected)
  
  # Test parameter name with numbers
  expected <- paste0(
    "@param dem2 Raster object of class [WhiteboxRaster]. ",
    "See [wbw_read_raster()] for more details."
  )
  expect_equal(rd_input_raster("dem2"), expected)
})

test_that("rd_example creates correct example documentation", {
  # Test without arguments
  expected <- paste(
    "@examples",
    'f <- system.file("extdata/dem.tif", package = "wbw")',
    "wbw_read_raster(f) |>",
    "  slope()",
    sep = "\n"
  )
  expect_equal(rd_example("slope"), expected)
  
  # Test with single argument
  expected <- paste(
    "@examples",
    'f <- system.file("extdata/dem.tif", package = "wbw")',
    "wbw_read_raster(f) |>",
    "  slope(units = 'degrees')",
    sep = "\n"
  )
  expect_equal(rd_example("slope", "units = 'degrees'"), expected)
  
  # Test with multiple arguments
  expected <- paste(
    "@examples",
    'f <- system.file("extdata/dem.tif", package = "wbw")',
    "wbw_read_raster(f) |>",
    "  breach_depressions(max_depth = 10, max_length = 100)",
    sep = "\n"
  )
  expect_equal(
    rd_example(
      "breach_depressions", 
      c("max_depth = 10", "max_length = 100")
    ),
    expected
  )
  
  # Test with NULL arguments
  expected <- paste(
    "@examples",
    'f <- system.file("extdata/dem.tif", package = "wbw")',
    "wbw_read_raster(f) |>",
    "  slope()",
    sep = "\n"
  )
  expect_equal(rd_example("slope", NULL), expected)
})

test_that("documentation functions handle edge cases", {
  # Test empty strings
  expect_error(rd_wbw_link(""))
  expect_error(rd_input_raster(""))
  expect_error(rd_example(""))
  
  # Test NULL inputs
  expect_error(rd_wbw_link(NULL))
  expect_error(rd_input_raster(NULL))
  expect_error(rd_example(NULL))
  
  # Test non-character inputs
  expect_error(rd_wbw_link(123))
  expect_error(rd_input_raster(123))
  expect_error(rd_example(123))
}) 