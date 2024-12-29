#' Convert to radians
#' @keywords conversions
#'
#' Converts [WhiteboxRaster] in degrees to radians
#'
#' @eval rd_input_raster("x")
#'
#' @return [WhiteboxRaster] object in radians
#'
#' @seealso [wbw_to_degrees()], [wbw_slope()]
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(raster_path) |>
#'   wbw_slope(units = "d") |>
#'   wbw_to_radians()
#' }
#' @export
wbw_to_radians <-
  S7::new_generic(
    name = "wbw_to_radians",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_to_radians, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    # Return Raster
    WhiteboxRaster(
      name = if (grepl("\\(degrees\\)", x@name)) {
        sub("\\(degrees\\)", "(radians)", x@name)
      } else {
        x@name
      },
      source = x@source$to_radians()
    )
  }

#' Convert to degrees
#' @keywords conversions
#'
#' Converts [WhiteboxRaster] in radians to degrees
#'
#' @eval rd_input_raster("x")
#'
#' @return [WhiteboxRaster] object in degrees
#'
#' @seealso [wbw_to_radians()], [wbw_slope()]
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(raster_path) |>
#'   wbw_slope(units = "r") |>
#'   wbw_to_degrees()
#' }
#' @export
wbw_to_degrees <-
  S7::new_generic(
    name = "wbw_to_degrees",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_to_degrees, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)
    # Return Raster
    WhiteboxRaster(
      name = if (grepl("\\(radians\\)", x@name)) {
        sub("\\(radians\\)", "(degrees)", x@name)
      } else {
        x@name
      },
      source = x@source$to_degrees()
    )
  }


#' Convert WhiteboxRaster to SpatRaster
#' @keywords conversions
#'
#' Converts [WhiteboxRaster] to SpatRaster object
#'
#' @eval rd_input_raster("x")
#'
#' @return SpatRaster object
#'
#' @seealso [WhiteboxRaster]
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' wbw_read_raster(raster_path) |>
#'   wbw_slope(units = "r") |>
#'   as_rast()
#' }
#' @export
as_rast <-
  S7::new_generic(
    name = "as_rast",
    dispatch_args = "x",
    fun = function(x) {
      S7::S7_dispatch()
    }
  )

S7::method(as_rast, WhiteboxRaster) <-
  function(x) {
    # Checks
    check_env(wbe)

    # Prep
    v <- as.vector(x)
    ext <-
      c(
        x@extent@west,
        x@extent@east + wbw_xres(x),
        x@extent@south - wbw_yres(x),
        x@extent@north
      )
    crs <- if (x@source$configs$epsg_code == 0) {
      x@source$configs$coordinate_ref_system_wkt
    } else {
      terra::crs(paste0("epsg:", x@source$configs$epsg_code))
    }
    # Convert
    terra::rast(
      vals = v,
      nlyrs = 1,
      crs = crs,
      extent = ext,
      resolution = wbw_res(x),
      names = x@name
    )
  }
