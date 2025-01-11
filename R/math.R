#' Random Sample
#' @keywords math
#'
#' @description
#' Creates a random sample of grid cells from a raster. Uses the input
#' WhiteboxRaster to determine grid dimensions and georeference information for
#' the output.
#'
#' The output grid will contain the specified number of non-zero grid cells,
#' randomly distributed throughout the raster. Each sampled cell will have a
#' unique value from 1 to num_samples, with background cells set to zero.
#'
#' @details
#' This tool is useful for statistical analyses of raster data where a random
#' sampling approach is needed. The sampling process only considers valid,
#' non-NoData cells from the input raster.
#'
#' @eval rd_input_raster("x")
#' @param num_samples \code{integer}, number of random samples. Must not exceed
#'   the total number of valid cells in the input raster (see [num_cells()]).
#'
#' @return [WhiteboxRaster] object
#'
#' @eval rd_wbw_link("random_sample")
#' @eval rd_example("wbw_random_sample", c("num_samples = 100"))
#'
#' @export
wbw_random_sample <- S7::new_generic(
  name = "wbw_random_sample",
  dispatch_args = "x",
  fun = function(x, num_samples = 1000L) {
    S7::S7_dispatch()
  }
)

# !NB:
# - set.seed() shouldn't work
S7::method(wbw_random_sample, WhiteboxRaster) <- function(
  x,
  num_samples = 1000L
) {
  # Checks
  check_env(wbe)
  num_samples <- checkmate::asInteger(
    num_samples,
    lower = 1L,
    upper = x@source$num_cells(),
    len = 1L
  )
  out <- wbe$random_sample(base_raster = x@source, num_samples = num_samples)
  # Return Raster
  WhiteboxRaster(
    name = x@name,
    source = out
  )
}
