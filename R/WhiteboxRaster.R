#' WhiteboxRaster Class
#'
#' A class representing a raster dataset in Whitebox format. The class provides access to
#' raster properties including name, source data, summary statistics, and min/max values.
#'
#' @param name Character, name of the raster
#' @param source Any, source data for the raster
#' @param stats Character, summary statistics for the raster
#' @param min Numeric, minimum value for the raster
#' @param max Numeric, maximum value for the raster
#' @export
WhiteboxRaster <-
  S7::new_class(
    name = "WhiteboxRaster",
    package = "wbw",
    properties = list(
      name = S7::class_character,
      source = S7::class_any,
      stats = S7::new_property(
        class = S7::class_character,
        getter = function(self) {
          check_env(wbe)
          wbe$raster_summary_stats(self@source)
        }
      ),
      min = S7::new_property(
        class = S7::class_double,
        getter = function(self) {
          extract_stat(self@stats, "minimum")
        },
        validator = function(value) {
          if (!is.numeric(value) || length(value) != 1) {
            return("@min must be a single numeric value")
          }
        }
      ),
      max = S7::new_property(
        class = S7::class_double,
        getter = function(self) {
          extract_stat(self@stats, "maximum")
        },
        validator = function(value) {
          if (!is.numeric(value) || length(value) != 1) {
            return("@max must be a single numeric value")
          }
        }
      )
    )#,
    # validator = function(self) {
    #   if (self@max < self@min) {
    #     sprintf(
    #       "@max (%a) must be greater than or equal to @min (%a)",
    #       self@max,
    #       self@min
    #     )
    #   }
    # }
  )
