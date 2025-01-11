#' @importFrom grDevices xy.coords
NULL

#' @exportS3Method xy.coords wbw::WhiteboxRaster
NULL

#' Convert WhiteboxRaster to x-y coordinates
#'
#' This is an internal method used by the plotting system.
#' It returns NULL coordinates to prevent default plotting behavior.
#'
#' @param x WhiteboxRaster object
#' @param ... additional arguments (not used)
#' @return A list with NULL x and y components
#' @keywords internal
#' @export
`xy.coords.wbw::WhiteboxRaster` <- function(x, ...) {
  list(x = NULL, y = NULL)
}

#' Plot WhiteboxRaster
#' @keywords methods
#'
#' @param x WhiteboxRaster object
#' @param col Colors to use for plotting
#' @param add Logical, whether to add to existing plot
#' @param ... Additional arguments passed to plot
#' @export
`plot.wbw::WhiteboxRaster` <- function(
  x,
  col = grDevices::terrain.colors(100),
  add = FALSE,
  ...
) {
  # Get raster data as matrix
  z <- as_matrix(x, raw = FALSE)

  # Get extent
  conf <- x@source$configs
  ext <- c(conf$west, conf$east, conf$south, conf$north)

  # Create plot
  if (!add) {
    graphics::plot.new()
    graphics::plot.window(ext[1:2], ext[3:4], asp = 1)
  }

  # Plot raster
  graphics::rasterImage(
    grDevices::as.raster(
      matrix(
        col[cut(z, breaks = length(col))],
        nrow = nrow(z),
        ncol = ncol(z)
      )
    ),
    ext[1],
    ext[3],
    ext[2],
    ext[4]
  )

  # Add axes and box if not adding to existing plot
  if (!add) {
    graphics::box()
    graphics::axis(1)
    graphics::axis(2)
  }

  invisible(x)
}
