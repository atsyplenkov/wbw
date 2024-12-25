#' Print method for WbwRaster
#' @param x WbwRaster object to print
#' @param ... additional arguments passed to print
#' @export
`print.wbw::WbwRaster` <-
  function(x, ...) {
    conf <- x@source$configs
    name <- if (nchar(conf$title) == 0) x@name else conf$title

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
      "EPSG        :",
      conf$epsg_code,
      "\n"
    )
    cat(
      "units       :",
      conf$xy_units,
      "\n"
    )
    # TODO:
    # - Coord Reference
    cat("min values  :", conf$display_min, "\n")
    cat("max values  :", conf$display_max, "\n")

    invisible(x)
  }
