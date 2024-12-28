#' Random sample
#' @keywords math
#'
#' @description
#' This tool can be used to create a random sample of grid cells. The user
#' specifies the [WhiteboxRaster], which is used to determine the grid
#' dimensions and georeference information for the output [WhiteboxRaster], and
#' the number of sample random samples (`num_samples`).
#'
#' The output grid will contain `num_samples` non-zero grid cells,
#' randomly distributed throughout the raster grid, and a background
#' value of **zero**. Every grid cell will have a value from `1`
#' to `num_samples`.
#'
#' @details
#' This tool is useful when performing statistical analyses on raster images
#' when you wish to obtain a random sample of data.
#'
#' Only valid, non-nodata, cells in the base raster will be sampled.
#'
#' @eval rd_input_raster("x")
#' @param num_samples \code{integer}, number of random samples. Should not
#' exceed total number of cells.
#'
#' @return [WhiteboxRaster] object
#'
#' @eval rd_wbw_link("random_sample")
#' @eval rd_example_geomorph("random_sample", c("num_samples = 100"))
#'
#' @export
wbw_random_sample <-
  S7::new_generic(
    name = "wbw_random_sample",
    dispatch_args = "x",
    fun = function(x, num_samples = 1000L) {
      S7::S7_dispatch()
    }
  )

# !NB:
# - set.seed() shouldn't work
S7::method(wbw_random_sample, WhiteboxRaster) <-
  function(x, num_samples = 1000L) {
    # Checks
    check_env(wbe)
    num_samples <-
      checkmate::asInteger(
        num_samples,
        lower = 1L,
        upper = x@source$num_cells(),
        len = 1L
      )
    out <-
      wbe$random_sample(base_raster = x@source, num_samples = num_samples)
    # Return Raster
    WhiteboxRaster(
      name = x@name,
      source = out
    )
  }

# TODO:
# Add ncell() function as a wrapper around `x@source$num_cells()`
