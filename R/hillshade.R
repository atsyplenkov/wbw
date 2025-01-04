#' Multidirectional Hillshade
#' @keywords geomorphometry
#'
#' @description
#' This tool performs a hillshade operation (also called shaded relief) on 
#' an input digital elevation model (DEM) with multiple sources of 
#' illumination.
#'
#' @details
#' The hillshade value (HS) of a DEM grid cell is calculate as:
#' \deqn{HS = \frac{\tan(s)}{\sqrt{1 - \tan(s)^2}} \times [\frac{\sin(Alt)}{\tan(s)} -
#'   \cos(Alt) \times \sin(Az - a)]}
#' where \eqn{s} and \eqn{a} are the local slope gradient and aspect (orientation)
#' respectively and \eqn{Alt} and \eqn{Az} are the illumination source altitude and azimuth
#' respectively. Slope and aspect are calculated using Horn's (1981) 3rd-order
#' finate difference method.
#'
#' @eval rd_input_raster("dem")
#' @param altitude \code{double}, the altitude of the illumination sources.
#' i.e. the elevation of the sun above the horizon, measured as an angle from
#' 0 to 90 degrees
#' @param z_factor \code{double}, Z conversion factor is only important
#' when the vertical and horizontal units are not the same in the DEM.
#' When this is the case, the algorithm will multiply each elevation in the
#' DEM by the Z conversion factor
#' @param full_360_mode \code{boolean}, default \code{FALSE}. I.e. whether or
#' not to use full 360-degrees of illumination sources. When \code{FALSE}
#' (default) the tool will perform a weighted summation of the hillshade
#' images from four illumination azimuth positions at 225, 270, 315, and
#' 360 (0) degrees, given weights of 0.1, 0.4, 0.4, and 0.1 respectively. When
#' run in the full 360-degree mode, eight illumination source azimuths are
#' used to calculate the output at 0, 45, 90, 135, 180, 225, 270, and 315
#' degrees, with weights of 0.15, 0.125, 0.1, 0.05, 0.1, 0.125, 0.15,
#' and 0.2 respectively.
#'
#' @return [WhiteboxRaster] object
#'
#' @eval rd_wbw_link("multidirectional_hillshade")
#' @references 
#' Horn B.K.P., 1981, Hill shading and the reflectance map, Proceedings of 
#' the I.E.E.E. 69, 14
#' 
#' @eval rd_example("wbw_multidirectional_hillshade")
#'
#' @export
wbw_multidirectional_hillshade <-
  S7::new_generic(
    name = "wbw_multidirectional_hillshade",
    dispatch_args = "dem",
    fun = function(dem,
                   altitude = 30,
                   z_factor = 1,
                   full_360_mode = FALSE) {
      S7::S7_dispatch()
    }
  )

S7::method(wbw_multidirectional_hillshade, WhiteboxRaster) <-
  function(dem,
           altitude = 30,
           z_factor = 1,
           full_360_mode = FALSE) {
    # Checks
    check_env(wbe)
    checkmate::assert_double(altitude, len = 1, lower = 0, upper = 90)
    checkmate::assert_double(z_factor, len = 1)
    checkmate::assert_logical(full_360_mode, len = 1)

    # WBT
    out <- wbe$multidirectional_hillshade(
      dem = dem@source,
      altitude = altitude,
      z_factor = z_factor,
      full_360_mode = full_360_mode
    )

    # Return
    WhiteboxRaster(
      name = paste0(dem@name, "(Hillshade)"),
      source = out
    )
  }
