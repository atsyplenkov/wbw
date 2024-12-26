#' WbwRaster Class
#' 
#' @param name Character, name of the raster
#' @param source Any, source data for the raster
#' @export
WbwRaster <-
  S7::new_class(
    name = "WbwRaster",
    properties = list(
      name = S7::class_character,
      source = S7::class_any
    ),
    package = "wbw"
  )