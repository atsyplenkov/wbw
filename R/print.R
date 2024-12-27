#' Print method for WhiteboxRaster
#' @param x [WhiteboxRaster] object to print
#' @param ... additional arguments passed to print
#' @export
`print.wbw::WhiteboxRaster` <- function(x, ...) {
  conf <- x@source$configs
  name <- if (nchar(conf$title) == 0) x@name else conf$title
  epsg <- if (conf$epsg_code != 0) conf$epsg_code else "<NA>"

  # Create content
  lines <- c(
    # Split class name to remove namespace
    sub("^.*::", "", class(x)[1]), # Remove namespace from class
    name, # Move name to second line
    sprintf("bands       : %d", conf$bands),
    sprintf("dimensions  : %d, %d  (nrow, ncol)", conf$rows, conf$columns),
    sprintf(
      "resolution  : %f, %f  (x, y)",
      conf$resolution_x, conf$resolution_y
    ),
    sprintf("EPSG        : %s  (%s)", epsg, conf$xy_units),
    sprintf("min value   : %f", x@min),
    sprintf("max value   : %f", x@max)
  )

  # Find the longest line
  width <- max(nchar(lines))

  # Create box elements with ASCII
  horizontal_line <- paste0("+", paste(rep("-", width + 2), collapse = ""), "+")
  dotted_line <- paste0("|", paste(rep(".", width + 2), collapse = ""), "|")

  # Print boxed content
  cat(horizontal_line, "\n")

  # Print class name and file name
  padded_class <- format(lines[1], width = width)
  padded_name <- format(lines[2], width = width)
  cat("| ", padded_class, " |\n", sep = "")
  cat("| ", padded_name, " |\n", sep = "")

  # Print separator
  cat(dotted_line, "\n")

  # Print rest of the content (skip first two lines as they're already printed)
  for (line in lines[-(1:2)]) {
    padded_line <- format(line, width = width)
    cat("| ", padded_line, " |\n", sep = "")
  }

  cat(horizontal_line, "\n")

  invisible(x)
}

#' Print GeoTIFFs tags
#'
#' @description
#' This tool can be used to view the tags contained within a GeoTiff file.
#' Viewing the tags of a GeoTiff file can be useful when trying to import
#' the GeoTiff to different software environments. The user must specify the
#' name of a GeoTiff file and the tag information will be printed in the
#' console. Note that tags that contain greater than 100
#' values will be truncated in the output. GeoKeys will also be interpreted
#'  as per the GeoTIFF specification.
#'
#' @param file_name \code{character}, path to raster file.
#'
#' @eval rd_wbw_link("print_geotiff_tags")
#'
#' @examples
#' \dontrun{
#' raster_path <- system.file("extdata/dem.tif", package = "wbw")
#' print_geotiff_tags(raster_path)
#' }
#'
#' @export
print_geotiff_tags <-
  function(file_name) {
    check_env(wbe)
    check_input_file(file_name, "r")
    wbe$print_geotiff_tags(file_name)
  }
