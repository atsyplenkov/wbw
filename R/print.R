#' Print Method for WhiteboxRaster
#' @keywords methods
#'
#' @param x [WhiteboxRaster] object to print
#' @param ... additional arguments passed to print method
#' @export
`print.wbw::WhiteboxRaster` <- function(x, ...) {
  conf <- x@source$configs
  name <- if (nchar(conf$title) == 0) x@name else conf$title
  epsg <- if (conf$epsg_code != 0) conf$epsg_code else "<NA>"

  # Create content
  lines <- c(
    sub("^.*::", "", class(x)[1]),
    name,
    sprintf("bands       : %d", conf$bands),
    sprintf("dimensions  : %d, %d  (nrow, ncol)", conf$rows, conf$columns),
    sprintf(
      "resolution  : %f, %f  (x, y)",
      conf$resolution_x,
      conf$resolution_y
    ),
    sprintf("EPSG        : %s  (%s)", epsg, conf$xy_units),
    sprintf(
      "extent      : %1.0f %1.0f %1.0f %1.0f",
      conf$west,
      conf$east,
      conf$south,
      conf$north
    ),
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

#' Print GeoTIFF Tags
#' @keywords utils
#'
#' @description
#' Displays the tags contained within a GeoTIFF file. This is useful when
#' importing GeoTIFF files into different software environments. The tool prints
#' tag information to the console. Tags containing more than 100 values are
#' truncated in the output. GeoKeys are interpreted according to the GeoTIFF
#' specification.
#'
#' @param file_name \code{character}, path to raster file
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
print_geotiff_tags <- function(file_name) {
  check_env(wbe)
  check_input_file(file_name, "r")
  wbe$print_geotiff_tags(file_name)
}
