#' WhiteboxExtent Class
#' @keywords class
#'
#' @description
#' Defines the spatial extent of a raster dataset using coordinates for
#' the west, east, south, and north boundaries.
#'
#' @param west \code{double} Western boundary coordinate
#' @param east \code{double} Eastern boundary coordinate
#' @param south \code{double} Southern boundary coordinate
#' @param north \code{double} Northern boundary coordinate
#'
#' @export
WhiteboxExtent <- S7::new_class(
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
#' @description
#' Represents a raster dataset in Whitebox Workflows for Python (WbW) format.
#' Provides access to raster properties including name, Python pointer, summary
#' statistics, and min/max values.
#'
#' @param name \code{character} Name of the raster
#' @param source \code{any} Source data for the raster
#'
#' @section Properties:
#' \describe{
#'   \item{stats}{\code{character} Summary statistics for the raster}
#'   \item{min}{\code{numeric} Minimum value for the raster}
#'   \item{max}{\code{numeric} Maximum value for the raster}
#'   \item{extent}{\code{WhiteboxExtent} Spatial extent of the raster}
#' }
#' @export
WhiteboxRaster <- S7::new_class(
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
    # extent = S7::new_property(
    #   class = WhiteboxExtent,
    #   getter = function(self) {
    #     conf <- self@source$configs
    #     WhiteboxExtent(
    #       west = conf$west,
    #       east = conf$east,
    #       south = conf$south,
    #       north = conf$north
    #     )
    #   }
    # )
  )
)
