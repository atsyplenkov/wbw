#' WhiteboxExtent Class
#' @keywords class
#'
#' @param west \code{double}
#' @param east \code{double}
#' @param south \code{double}
#' @param north \code{double}
#'
#' @export
WhiteboxExtent <-
  S7::new_class(
    name = "WhiteboxExtent",
    package = "wbw",
    properties = list(
      west = S7::new_property(
        class = S7::class_double,
        validator = function(value) {
          if (length(value) != 1) {
            return("'west' must be a single numeric value")
          }
        }
      ),
      east = S7::new_property(
        class = S7::class_double,
        validator = function(value) {
          if (length(value) != 1) {
            return("'east' must be a single numeric value")
          }
        }
      ),
      south = S7::new_property(
        class = S7::class_double,
        validator = function(value) {
          if (length(value) != 1) {
            return("'south' must be a single numeric value")
          }
        }
      ),
      north = S7::new_property(
        class = S7::class_double,
        validator = function(value) {
          if (length(value) != 1) {
            return("'north' must be a single numeric value")
          }
        }
      )
    )
  )


#' WhiteboxRaster Class
#' @keywords class
#'
#' A class representing a raster dataset in Whitebox format.
#' The class provides access to raster properties including name,
#' Python pointer, summary statistics, and min/max values.
#'
#' @param name Character, name of the raster
#' @param source Any, source data for the raster
#'
#' @section Properties:
#' \describe{
#'   \item{stats}{Character, summary statistics for the raster}
#'   \item{min}{Numeric, minimum value for the raster}
#'   \item{max}{Numeric, maximum value for the raster}
#'   \item{extent}{WhiteboxExtent, spatial extent of the raster}
#' }
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
      ),
      extent = S7::new_property(
        class = WhiteboxExtent,
        getter = function(self) {
          conf <- self@source$configs
          WhiteboxExtent(
            west = conf$west,
            east = conf$east,
            south = conf$south,
            north = conf$north
          )
        }
      )
    )
  )
