#' Aspect
#' @rdname wbw_aspect
#' @keywords geomorphometry
#'
#' @description
#' Calculates slope aspect (i.e., slope orientation in degrees clockwise from
#' north) for each grid cell in an input DEM.
#'
#' @details
#' For DEMs in projected coordinate systems, the tool uses the 3rd-order
#' bivariate Taylor polynomial method described by Florinsky (2016). Based on a
#' polynomial fit of elevations within the 5x5 neighborhood surrounding each
#' cell, this method is more robust against outlier elevations (noise) than
#' other methods.
#'
#' For DEMs in geographic coordinate systems (i.e., angular units), the tool
#' uses the 3x3 polynomial fitting method for equal angle grids also described
#' by Florinsky (2016).
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
#' @eval rd_example("wbw_aspect")
#'
#' @seealso [wbw_to_degrees()], [wbw_to_radians()], [wbw_slope()]
#'
#' @export
wbw_aspect <- S7::new_generic(
  name = "wbw_aspect",
  dispatch_args = "dem",
  fun = function(dem, z_factor = 1.0) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_aspect, WhiteboxRaster) <- function(dem, z_factor = 1.0) {
  # Checks
  check_env(wbe)
  checkmate::assert_double(z_factor, len = 1)
  # Estimate aspect
  out <- wbe$aspect(dem = dem@source, z_factor = z_factor)
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
#' Calculates slope gradient (i.e., slope steepness in degrees, radians, or
#' percent) for each grid cell in an input digital elevation model (DEM).
#'
#' @details
#' The tool uses Horn's (1981) 3rd-order finite difference method to estimate
#' slope. Given the following clock-type grid cell numbering scheme (Gallant and
#' Wilson, 2000).
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
#' @eval rd_example("wbw_slope", args = c('units = "radians"'))
#'
#' @seealso [wbw_to_degrees()], [wbw_to_radians()], [wbw_aspect()]
#'
#' @export
wbw_slope <- S7::new_generic(
  name = "wbw_slope",
  dispatch_args = "dem",
  fun = function(dem, units = "degrees", z_factor = 1.0) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_slope, WhiteboxRaster) <- function(
  dem,
  units = "degrees",
  z_factor = 1.0
) {
  # Checks
  check_env(wbe)
  units <- checkmate::matchArg(
    units,
    choices = c("radians", "degrees", "percent")
  )
  checkmate::assert_double(z_factor, len = 1)
  # Estimate slope
  out <- wbe$slope(dem = dem@source, units = units, z_factor = z_factor)
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
#' Calculates a measure of local topographic relief. The TRI computes the
#' root-mean-square-deviation (RMSD) for each grid cell in a DEM by calculating
#' the residuals between a cell and its eight neighbors.
#'
#' @details
#' Unlike the original Riley et al. (1999) TRI, this implementation normalizes
#' for the number of cells in the local window. This modification allows for
#' varying numbers of neighboring cells along grid edges and areas bordering
#' NoData cells. Note that this means output values cannot be directly compared
#' with the index ranges (level to extremely rugged terrain) provided in Riley
#' et al. (1999).
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
#' @eval rd_example("wbw_ruggedness_index")
#'
#' @export
wbw_ruggedness_index <- S7::new_generic(
  name = "wbw_ruggedness_index",
  dispatch_args = "dem",
  fun = function(dem) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_ruggedness_index, WhiteboxRaster) <- function(dem) {
  # Checks
  check_env(wbe)
  out <- wbe$ruggedness_index(input = dem@source)
  WhiteboxRaster(
    name = paste0("TRI"),
    source = out
  )
}

#' Fill Missing Data
#' @keywords geomorphometry
#'
#' @description
#' This tool can be used to fill in small gaps in a raster or digital elevation
#' model (DEM). The gaps, or holes, must have recognized NoData values.
#' If gaps do not currently have this characteristic, use the
#' \code{set_nodata_value} tool and ensure that the data are stored using
#' a raster format that supports NoData values.
#' All valid, non-NoData values in the input raster will be assigned the same
#' value in the output image.
#'
#' @details
#' The algorithm uses an inverse-distance weighted (IDW) scheme based on the
#'  valid values on the edge of NoData gaps to estimate gap values.
#' The user must specify the filter size (\code{filter_size}), which
#' determines the size of gap that is filled, and the IDW weight
#' (\code{weight}).
#'
#' @eval rd_input_raster("x")
#' @param filter_size \code{integer} in **grid cells** is used to determine
#' how far the algorithm will search for valid, non-NoData values. Therefore,
#' setting a larger filter size allows for the filling of larger gaps in
#' the input raster.
#' @param weight \code{double}, the IDW weight.
#' @param exclude_edge_nodata \code{boolean}, default \code{FALSE}. It can be
#' used to exclude NoData values that are connected to the edges of the raster.
#' It is usually the case that irregularly shaped DEMs have large regions
#' of NoData values along the containing raster edges. This flag can be used
#' to exclude these regions from the gap-filling operation, leaving only
#' interior gaps for filling.
#'
#' @return [WhiteboxRaster] object
#'
#' @eval rd_wbw_link("fill_missing_data")
#' @eval rd_example("wbw_fill_missing_data")
#'
#' @export
wbw_fill_missing_data <- S7::new_generic(
  name = "wbw_fill_missing_data",
  dispatch_args = "x",
  fun = function(
    x,
    filter_size = 11L,
    weight = 2,
    exclude_edge_nodata = FALSE
  ) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_fill_missing_data, WhiteboxRaster) <- function(
  x,
  filter_size = 11L,
  weight = 2,
  exclude_edge_nodata = FALSE
) {
  # Checks
  check_env(wbe)
  filter_size <- checkmate::asInteger(
    filter_size,
    lower = 0L,
    len = 1L
  )
  checkmate::assert_double(weight, len = 1)
  checkmate::assert_logical(exclude_edge_nodata, len = 1)

  # WBT
  out <- wbe$fill_missing_data(
    dem = x@source,
    filter_size = filter_size,
    weight = weight,
    exclude_edge_nodata = exclude_edge_nodata
  )

  # Return
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}
