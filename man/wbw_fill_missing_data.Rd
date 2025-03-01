% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geomorphometry.R
\name{wbw_fill_missing_data}
\alias{wbw_fill_missing_data}
\title{Fill Missing Data}
\usage{
wbw_fill_missing_data(
  x,
  filter_size = 11L,
  weight = 2,
  exclude_edge_nodata = FALSE
)
}
\arguments{
\item{x}{Raster object of class \link{WhiteboxRaster}. See \code{\link[=wbw_read_raster]{wbw_read_raster()}} for more details.}

\item{filter_size}{\code{integer} in \strong{grid cells} is used to determine
how far the algorithm will search for valid, non-NoData values. Therefore,
setting a larger filter size allows for the filling of larger gaps in
the input raster.}

\item{weight}{\code{double}, the IDW weight.}

\item{exclude_edge_nodata}{\code{boolean}, default \code{FALSE}. It can be
used to exclude NoData values that are connected to the edges of the raster.
It is usually the case that irregularly shaped DEMs have large regions
of NoData values along the containing raster edges. This flag can be used
to exclude these regions from the gap-filling operation, leaving only
interior gaps for filling.}
}
\value{
\link{WhiteboxRaster} object
}
\description{
This tool can be used to fill in small gaps in a raster or digital elevation
model (DEM). The gaps, or holes, must have recognized NoData values.
If gaps do not currently have this characteristic, use the
\code{set_nodata_value} tool and ensure that the data are stored using
a raster format that supports NoData values.
All valid, non-NoData values in the input raster will be assigned the same
value in the output image.
}
\details{
The algorithm uses an inverse-distance weighted (IDW) scheme based on the
valid values on the edge of NoData gaps to estimate gap values.
The user must specify the filter size (\code{filter_size}), which
determines the size of gap that is filled, and the IDW weight
(\code{weight}).
}
\examples{
f <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(f) |>
  wbw_fill_missing_data()
}
\references{
For more information, see \url{https://www.whiteboxgeo.com/manual/wbw-user-manual/book/tool_help.html#fill_missing_data}
}
\keyword{geomorphometry}
