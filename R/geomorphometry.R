#' Aspect
#' @rdname wbw_aspect
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates slope aspect (i.e. slope orientation in degrees
#' clockwise from north) for each grid cell in an input DEM of
#' class [WhiteboxRaster].
#'
#' @details
#' For DEMs in projected coordinate systems, the tool uses the 3rd-order
#' bivariate Taylor polynomial method described by Florinsky (2016). Based
#' on a polynomial fit of the elevations within the 5x5 neighbourhood
#' surrounding each cell, this method is considered more robust against
#' outlier elevations (noise) than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the tool
#'  uses the 3x3 polynomial fitting method for equal angle grids also described
#'  by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object containing aspect in degrees
#'
#' @references
#' Gallant, J. C., and J. P. Wilson, 2000, Primary topographic attributes,
#' in Terrain Analysis: Principles and Applications, edited by J. P. Wilson
#' and J. C. Gallant pp. 51-86, John Wiley, Hoboken, N.J.
#'
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#' geology. Academic Press.
#'
#' @eval rd_wbw_link("aspect")
#' @eval rd_example_geomorph("wbw_aspect")
#'
#' @seealso [wbw_to_degrees()], [wbw_to_radians()], [wbw_slope()]
#'
#' @export
wbw_aspect <-
  S7::new_generic(
    name = "wbw_aspect",
    dispatch_args = "dem",
    fun = function(dem, z_factor = 1.0) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_aspect, WhiteboxRaster) <-
  function(dem,
           z_factor = 1.0) {
    # Checks
    check_env(wbe)
    checkmate::assert_double(z_factor)
    # Estimate slope
    out <-
      wbe$slope(dem = dem@source, z_factor = z_factor)
    # Return Raster
    WhiteboxRaster(
      name = paste0("Aspect"),
      source = out
    )
  }

#' Slope
#' @rdname wbw_slope
#' @keywords geomorphometry
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
#' @eval rd_input_raster("dem")
#' @param units \code{character},
#' units of slope: "radians", "degrees", or "percent"
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object containing slope values
#'
#' @references
#' Gallant, J. C., and J. P. Wilson, 2000, Primary topographic attributes,
#' in Terrain Analysis: Principles and Applications, edited by J. P. Wilson
#' and J. C. Gallant pp. 51-86, John Wiley, Hoboken, N.J.
#'
#' @eval rd_wbw_link("slope")
#' @eval rd_example_geomorph("wbw_slope", args = c('units = "radians"'))
#'
#' @seealso [wbw_to_degrees()], [wbw_to_radians()], [wbw_aspect()]
#'
#' @export
wbw_slope <-
  S7::new_generic(
    name = "wbw_slope",
    dispatch_args = "dem",
    fun = function(dem, units = "degrees", z_factor = 1.0) {
      S7::S7_dispatch()
    }
  )


S7::method(wbw_slope, WhiteboxRaster) <-
  function(dem,
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
      wbe$slope(dem = dem@source, units = units, z_factor = z_factor)
    # Return Raster
    WhiteboxRaster(
      name = paste0("Slope (", units, ")"),
      source = out
    )
  }

#' Terrain Ruggedness Index (TRI)
#' @rdname wbw_ruggedness_index
#' @keywords geomorphometry
#'
#' @description
#' The terrain ruggedness index (TRI) is a measure of local topographic relief.
#' The TRI calculates the root-mean-square-deviation (RMSD) for each grid cell
#' in a digital elevation model (DEM), calculating the residuals (i.e.
#' elevation differences) between a grid cell and its eight neighbours.
#'
#' @details
#' Notice that, unlike the output of this tool, the original Riley et al.
#' (1999) TRI did not normalize for the number of cells in the local window
#'  (i.e. it is a root-square-deviation only). However, using the mean has
#' the advantage of allowing for the varying number of neighbouring cells
#' along the grid edges and in areas bordering NoData cells. This modification
#' does however imply that the output of this tool cannot be directly compared
#' with the index ranges of level to extremely rugged terrain provided in
#' Riley et al. (1999)
#'
#' @eval rd_input_raster("dem")
#'
#' @return [WhiteboxRaster] object containing TRI values
#'
#' @references
#' Riley, S. J., DeGloria, S. D., and Elliot, R. (1999). Index that quantifies
#' topographic heterogeneity. Intermountain Journal of Sciences, 5(1-4), 23-27.
#'
#' @eval rd_wbw_link("ruggedness_index")
#' @eval rd_example_geomorph("wbw_ruggedness_index")
#'
#' @export
wbw_ruggedness_index <-
  S7::new_generic(
    name = "wbw_ruggedness_index",
    dispatch_args = "dem",
    fun = function(dem) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_ruggedness_index, WhiteboxRaster) <-
  function(dem) {
    # Checks
    check_env(wbe)
    # Estimate slope
    out <-
      wbe$ruggedness_index(input = dem@source)
    # Return Raster
    WhiteboxRaster(
      name = paste0("TRI"),
      source = out
    )
  }
