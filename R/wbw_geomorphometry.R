#' Slope
#'
#' @description
#' This tool calculates slope gradient (i.e. slope steepness in degrees,
#' radians, or percent) for each grid cell in an input digital elevation
#' model (DEM).
#'
#' @details
#' The tool uses Horn's (1981) 3rd-order finite difference method to
#' estimate slope. Given the following clock-type grid cell numbering scheme
#' (Gallant and Wilson, 2000).
#'
#' @param units \code{character},
#' units of slope: "radians", "degrees", or "percent"
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#' 
#' @return WbwRaster object containing slope values
#'
#' @references
#' Gallant, J. C., and J. P. Wilson, 2000, Primary topographic attributes,
#' in Terrain Analysis: Principles and Applications, edited by J. P. Wilson
#' and J. C. Gallant pp. 51-86, John Wiley, Hoboken, N.J.
#'
#' @eval rd_wbw_link("slope")
#' @eval rd_input_raster("dem")
#'
#' @export
wbw_slope <- S7::new_generic("wbw_slope", "x")

S7::method(wbw_slope, WbwRaster) <-
  function(x,
           units = "degrees",
           z_factor = 1.0) {
    # Checks
    check_env(wbe)
    units <- checkmate::matchArg(
      units,
      choices = c("radians", "degrees", "percent")
    )
    checkmate::assert_double(z_factor)
    # Estimate slope
    out <- 
      wbe$slope(dem = x@source, units = units, z_factor = z_factor)
    # Return Raster
    WbwRaster(
      name = paste0("Slope (", units, ")"),
      source = out
    )
  }
