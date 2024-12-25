# helper function to create long URL links to WbW help page
rd_wbw_link <-
  function(fun_name) {
    paste0(
      "@references For more information, see ",
      "<https://www.whiteboxgeo.com/manual",
      "/wbw-user-manual/book/tool_help.html#",
      fun_name,
      ">"
    )
  }

rd_input_raster <- 
  function(param) {
    paste0(
      "@param ", param, 
      " Raster object of class `WbwRaster`. ",
      "See [wbw_read_raster()] for more details." 
    )
  }