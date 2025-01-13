#' Gaussian Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the Gaussian curvature from a digital elevation
#' model (\eqn{dem}). Gaussian curvature is the product of maximal and
#' minimal curvatures, and retains values in each point of the topographic
#' surface after its bending without breaking, stretching, and
#' compressing (Florinsky, 2017).
#'
#' Gaussian curvature is measured in units of \eqn{m^{-2}}.
#'
#' @details
#' Curvature values are often very small and as such the user may opt to
#' log-transform the output raster (\eqn{log_transform}). Transforming
#' the values applies the equation by Shary et al. (2002):
#'
#' \deqn{Θ' = sign(Θ) ln(1 + 10^n|Θ|)}
#'
#' where \eqn{Θ} is the parameter value and \eqn{n} is dependent on the
#' grid cell size.
#'
#' For DEMs in projected coordinate systems, the tool uses the
#' 3rd-order bivariate Taylor polynomial method described by
#' Florinsky (2016). Based on a polynomial fit of the elevations
#' within the 5x5 neighbourhood surrounding each cell, this method
#' is considered more robust against outlier elevations (noise)
#' than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the
#' tool uses the 3x3 polynomial fitting method for equal angle grids also
#' described by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object in units of \eqn{m^{-2}}.
#'
#' @eval rd_wbw_link("gaussian_curvature")
#' @references
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#'   geology. Academic Press. <br>
#' Florinsky, I. V. (2017). An illustrated introduction to general
#'   geomorphometry. Progress in Physical Geography, 41(6), 723-752. <br>
#' Shary P. A., Sharaya L. S. and Mitusov A. V. (2002) Fundamental
#'   quantitative methods of land surface analysis. Geoderma 107: 1–32. <br>
#'
#' @seealso [wbw_maximal_curvature()], [wbw_minimal_curvature()]
#'
#' @eval rd_example("wbw_gaussian_curvature")
#'
#' @export
wbw_gaussian_curvature <- S7::new_generic(
  name = "wbw_gaussian_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_gaussian_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$gaussian_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Gaussian Curvature",
    source = out
  )
}

#' Maximal Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the maximal curvature from a digital elevation model
#'  (\eqn{dem}). Maximal curvature is the curvature of a principal section
#' with the highest value of curvature at a given point of the topographic
#'  surface (Florinsky, 2017). The values of this curvature are unbounded,
#'  and positive values correspond to ridge positions while negative values
#' are indicative of closed depressions (Florinsky, 2016).
#'
#' Maximal curvature is measured in units of \eqn{m^{-1}}.
#'
#' @details
#' Curvature values are often very small and as such the user may opt to
#' log-transform the output raster (\eqn{log_transform}). Transforming
#' the values applies the equation by Shary et al. (2002):
#'
#' \deqn{Θ' = sign(Θ) ln(1 + 10^n|Θ|)}
#'
#' where \eqn{Θ} is the parameter value and \eqn{n} is dependent on the
#' grid cell size.
#'
#' For DEMs in projected coordinate systems, the tool uses the
#' 3rd-order bivariate Taylor polynomial method described by
#' Florinsky (2016). Based on a polynomial fit of the elevations
#' within the 5x5 neighbourhood surrounding each cell, this method
#' is considered more robust against outlier elevations (noise)
#' than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the
#' tool uses the 3x3 polynomial fitting method for equal angle grids also
#' described by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object in units of \eqn{m^{-1}}.
#'
#' @eval rd_wbw_link("maximal_curvature")
#' @references
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#'   geology. Academic Press. <br>
#' Florinsky, I. V. (2017). An illustrated introduction to general
#'   geomorphometry. Progress in Physical Geography, 41(6), 723-752. <br>
#' Shary P. A., Sharaya L. S. and Mitusov A. V. (2002) Fundamental
#'   quantitative methods of land surface analysis. Geoderma 107: 1–32. <br>
#'
#' @seealso [wbw_gaussian_curvature()], [wbw_minimal_curvature()]
#'
#' @eval rd_example("wbw_maximal_curvature")
#'
#' @export
wbw_maximal_curvature <- S7::new_generic(
  name = "wbw_maximal_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_maximal_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$maximal_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Maximal Curvature",
    source = out
  )
}

#' Minimal Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the minimal curvature from a digital elevation model
#'  (\eqn{dem}). Minimal curvature is the curvature of a principal section
#' with the highest value of curvature at a given point of the topographic
#'  surface (Florinsky, 2017). The values of this curvature are unbounded,
#'  and positive values correspond to ridge positions while negative values
#' are indicative of closed depressions (Florinsky, 2016).
#'
#' Minimal curvature is measured in units of \eqn{m^{-1}}.
#'
#' @details
#' Curvature values are often very small and as such the user may opt to
#' log-transform the output raster (\eqn{log_transform}). Transforming
#' the values applies the equation by Shary et al. (2002):
#'
#' \deqn{Θ' = sign(Θ) ln(1 + 10^n|Θ|)}
#'
#' where \eqn{Θ} is the parameter value and \eqn{n} is dependent on the
#' grid cell size.
#'
#' For DEMs in projected coordinate systems, the tool uses the
#' 3rd-order bivariate Taylor polynomial method described by
#' Florinsky (2016). Based on a polynomial fit of the elevations
#' within the 5x5 neighbourhood surrounding each cell, this method
#' is considered more robust against outlier elevations (noise)
#' than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the
#' tool uses the 3x3 polynomial fitting method for equal angle grids also
#' described by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object in units of \eqn{m^{-1}}.
#'
#' @eval rd_wbw_link("minimal_curvature")
#' @references
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#'   geology. Academic Press. <br>
#' Florinsky, I. V. (2017). An illustrated introduction to general
#'   geomorphometry. Progress in Physical Geography, 41(6), 723-752. <br>
#' Shary P. A., Sharaya L. S. and Mitusov A. V. (2002) Fundamental
#'   quantitative methods of land surface analysis. Geoderma 107: 1–32. <br>
#'
#' @seealso [wbw_gaussian_curvature()], [wbw_maximal_curvature()]
#'
#' @eval rd_example("wbw_minimal_curvature")
#'
#' @export
wbw_minimal_curvature <- S7::new_generic(
  name = "wbw_minimal_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_minimal_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$minimal_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Minimal Curvature",
    source = out
  )
}

#' Mean Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the mean curvature from a digital elevation
#' model (\eqn{dem}).
#'
#' WhiteboxTools reports curvature in radians multiplied by 100 for easier
#' interpretation because curvature values are typically very small.
#'
#' @details
#' Curvature values are often very small and as such the user may opt to
#' log-transform the output raster (\eqn{log_transform}). Transforming
#' the values applies the equation by Shary et al. (2002):
#'
#' \deqn{Θ' = sign(Θ) ln(1 + 10^n|Θ|)}
#'
#' where \eqn{Θ} is the parameter value and \eqn{n} is dependent on the
#' grid cell size.
#'
#' For DEMs in projected coordinate systems, the tool uses the
#' 3rd-order bivariate Taylor polynomial method described by
#' Florinsky (2016). Based on a polynomial fit of the elevations
#' within the 5x5 neighbourhood surrounding each cell, this method
#' is considered more robust against outlier elevations (noise)
#' than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the
#' tool uses the 3x3 polynomial fitting method for equal angle grids also
#' described by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object.
#'
#' @eval rd_wbw_link("mean_curvature")
#' @references
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#'   geology. Academic Press. <br>
#' Florinsky, I. V. (2017). An illustrated introduction to general
#'   geomorphometry. Progress in Physical Geography, 41(6), 723-752. <br>
#' Shary P. A., Sharaya L. S. and Mitusov A. V. (2002) Fundamental
#'   quantitative methods of land surface analysis. Geoderma 107: 1–32. <br>
#'
#' @seealso [wbw_gaussian_curvature()], [wbw_maximal_curvature()]
#'
#' @eval rd_example("wbw_mean_curvature")
#'
#' @export
wbw_mean_curvature <- S7::new_generic(
  name = "wbw_mean_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_mean_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$mean_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Mean Curvature",
    source = out
  )
}

#' Profile Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the profile curvature from a digital elevation
#' model (\eqn{dem}), or the rate of change in slope along a flow line.
#'
#' Curvature is the second derivative of the topographic surface defined
#'  by a DEM. Profile curvature characterizes the degree of downslope
#' acceleration or deceleration within the
#' landscape (Gallant and Wilson, 2000).
#'
#' WhiteboxTools reports curvature in radians multiplied by 100 for easier
#' interpretation because curvature values are typically very small.
#'
#' @details
#' Curvature values are often very small and as such the user may opt to
#' log-transform the output raster (\eqn{log_transform}). Transforming
#' the values applies the equation by Shary et al. (2002):
#'
#' \deqn{Θ' = sign(Θ) ln(1 + 10^n|Θ|)}
#'
#' where \eqn{Θ} is the parameter value and \eqn{n} is dependent on the
#' grid cell size.
#'
#' For DEMs in projected coordinate systems, the tool uses the
#' 3rd-order bivariate Taylor polynomial method described by
#' Florinsky (2016). Based on a polynomial fit of the elevations
#' within the 5x5 neighbourhood surrounding each cell, this method
#' is considered more robust against outlier elevations (noise)
#' than other methods.
#'
#' For DEMs in geographic coordinate systems (i.e. angular units), the
#' tool uses the 3x3 polynomial fitting method for equal angle grids also
#' described by Florinsky (2016).
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object.
#'
#' @eval rd_wbw_link("profile_curvature")
#' @references
#' Gallant, J. C., and J. P. Wilson, 2000, Primary topographic attributes,
#'   in Terrain Analysis: Principles and Applications, edited by J. P.
#'   Wilson and J. C. Gallant pp. 51-86, John Wiley, Hoboken, N.J. <br>
#' Florinsky, I. (2016). Digital terrain analysis in soil science and
#'   geology. Academic Press. <br>
#' Florinsky, I. V. (2017). An illustrated introduction to general
#'   geomorphometry. Progress in Physical Geography, 41(6), 723-752. <br>
#' Shary P. A., Sharaya L. S. and Mitusov A. V. (2002) Fundamental
#'   quantitative methods of land surface analysis. Geoderma 107: 1–32. <br>
#'
#' @seealso [wbw_gaussian_curvature()], [wbw_mean_curvature()]
#'
#' @eval rd_example("wbw_profile_curvature")
#'
#' @export
wbw_profile_curvature <- S7::new_generic(
  name = "wbw_profile_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_profile_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$profile_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Profile Curvature",
    source = out
  )
}

#' Plan Curvature
#' @keywords geomorphometry
#'
#' @description
#' This tool calculates the plan curvature (i.e. contour curvature), or
#' the rate of change in aspect along a contour line, from a digital
#' elevation model (\eqn{dem}). Curvature is the second derivative of the
#' topographic surface defined by a DEM. Plan curvature characterizes the
#'  degree of flow convergence or divergence within the
#' landscape (Gallant and Wilson, 2000).
#'
#' @details
#' WhiteboxTools reports curvature in degrees multiplied by 100 for easier 
#' interpretation. The Z conversion factor (\eqn{z_factor}) is only important 
#' when the vertical and horizontal units are not the same in the DEM. 
#' When this is the case, the algorithm will multiply each elevation in the 
#' DEM by the Z Conversion Factor. 
#' 
#' If the DEM is in the geographic coordinate system (latitude and longitude), 
#' the following equation is used:
#' 
#' \deqn{zfactor = \frac{1.0}{111320.0 \times \cos(midlat)}}
#' 
#' The algorithm uses the same formula for the calculation of plan curvature 
#' as Gallant and Wilson (2000). Plan curvature is negative for diverging 
#' flow along ridges and positive for convergent areas, 
#' e.g. along valley bottoms.
#'
#' @eval rd_input_raster("dem")
#' @param log_transform \code{logical}, default \code{FALSE}. Wheter
#' log-transform the output raster or not. See details.
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#'
#' @return [WhiteboxRaster] object.
#'
#' @eval rd_wbw_link("plan_curvature")
#' @references
#' Gallant, J. C., and J. P. Wilson, 2000, Primary topographic attributes,
#'   in Terrain Analysis: Principles and Applications, edited by J. P.
#'   Wilson and J. C. Gallant pp. 51-86, John Wiley, Hoboken, N.J. <br>
#'
#' @seealso [wbw_total_curvature()], [wbw_profile_curvature()]
#'
#' @eval rd_example("wbw_plan_curvature")
#'
#' @export
wbw_plan_curvature <- S7::new_generic(
  name = "wbw_plan_curvature",
  dispatch_args = "dem",
  fun = function(dem, log_transform = FALSE, z_factor = 1) {
    S7::S7_dispatch()
  }
)

S7::method(wbw_plan_curvature, WhiteboxRaster) <- function(
  dem,
  log_transform = FALSE,
  z_factor = 1
) {
  # Checks
  check_env(wbe)
  checkmate::assert_logical(log_transform, len = 1)
  checkmate::assert_double(z_factor, len = 1)

  # WBT
  out <- wbe$plan_curvature(
    dem = dem@source,
    log_transform = log_transform,
    z_factor = z_factor
  )

  # Return
  WhiteboxRaster(
    name = "Plan Curvature",
    source = out
  )
}
