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
  # Return NULL coordinates to prevent default plotting behavior
  list(x = NULL, y = NULL)
}

#' Plot WhiteboxRaster
#' @param x WhiteboxRaster object
#' @param col Colors to use for plotting
#' @param add Logical, whether to add to existing plot
#' @param legend Logical, whether to add legend
#' @param title Character, optional title (defaults to raster name if NULL)
#' @param ... Additional arguments passed to plot
#' @export
`plot.wbw::WhiteboxRaster` <- function(x, 
                                      col = grDevices::terrain.colors(100), 
                                      add = FALSE,
                                      legend = TRUE,
                                      title = NULL,
                                      ...) {
  # Get raster data as matrix
  z <- as.matrix(x)
  
  # Get extent
  conf <- x@source$configs
  ext <- c(conf$west, conf$east, conf$south, conf$north)
  
  # Set up plot margins if legend is to be added
  if (!add && legend) {
    graphics::par(mar = c(5, 4, 4, 6))
  }
  
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
    ext[1], ext[3], ext[2], ext[4]
  )
  
  # Add axes and title if not adding to existing plot
  if (!add) {
    graphics::box()
    graphics::axis(1)
    graphics::axis(2)
    graphics::title(main = if(is.null(title)) x@name else title)
    
    # Add legend
    if (legend) {
      # Calculate legend breaks and positions
      z_range <- range(z, na.rm = TRUE)
      legend_breaks <- pretty(z_range, n = 5)
      legend_y <- seq(z_range[1], z_range[2], length.out = length(col))
      legend_x <- graphics::par("usr")[2] + 0.1 * diff(graphics::par("usr")[1:2])
      
      # Draw color rectangles
      graphics::rect(legend_x,
           legend_y[-length(legend_y)],
           legend_x + 0.02 * diff(graphics::par("usr")[1:2]),
           legend_y[-1],
           col = col,
           border = NA)
      
      # Add legend axis
      graphics::axis(4, 
           at = legend_breaks,
           pos = legend_x + 0.02 * diff(graphics::par("usr")[1:2]))
    }
  }
  
  # Reset margins if they were changed
  if (!add && legend) {
    graphics::par(mar = c(5, 4, 4, 2) + 0.1)
  }
  

  invisible(x)
}
