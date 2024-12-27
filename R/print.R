#' Print method for WhiteboxRaster
#' @param x [WhiteboxRaster] object to print
#' @param ... additional arguments passed to print
#' @export
`print.wbw::WhiteboxRaster` <-
  function(x, ...) {
    conf <- x@source$configs
    name <- if (nchar(conf$title) == 0) x@name else conf$title
    epsg <- if (conf$epsg_code != 0) conf$epsg_code else "<NA>"

    cat(name, "\n")
    cat(
      "class       :",
      class(x)[1], "\n"
    )
    cat(
      "bands       :",
      conf$bands,
      "\n"
    )
    cat(
      "dimensions  : ",
      conf$rows, ", ",
      conf$columns,
      "  (nrow, ncol)\n",
      sep = ""
    )
    cat(
      "resolution  : ",
      conf$resolution_x, ", ",
      conf$resolution_y, "  (x, y)\n",
      sep = ""
    )
    cat(
      "EPSG        : ",
      epsg,
      "  (", conf$xy_units, ")\n",
      sep = ""
    )
    # TODO:
    # - Coord Reference
    cat("min value   :", x@min, "\n")
    cat("max value   :", x@max, "\n")

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
