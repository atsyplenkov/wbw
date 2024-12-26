#' WhiteboxRaster Class
#'
#' @param name Character, name of the raster
#' @param source Any, source data for the raster
#' @export
WhiteboxRaster <-
  S7::new_class(
    name = "WhiteboxRaster",
    package = "wbw",
    properties = list(
      name = S7::class_character,
      source = S7::class_any
    )
  )
