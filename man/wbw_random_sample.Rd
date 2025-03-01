% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/math.R
\name{wbw_random_sample}
\alias{wbw_random_sample}
\title{Random Sample}
\usage{
wbw_random_sample(x, num_samples = 1000L)
}
\arguments{
\item{x}{Raster object of class \link{WhiteboxRaster}. See \code{\link[=wbw_read_raster]{wbw_read_raster()}} for more details.}

\item{num_samples}{\code{integer}, number of random samples. Must not exceed
the total number of valid cells in the input raster (see \code{\link[=num_cells]{num_cells()}}).}
}
\value{
\link{WhiteboxRaster} object
}
\description{
Creates a random sample of grid cells from a raster. Uses the input
WhiteboxRaster to determine grid dimensions and georeference information for
the output.

The output grid will contain the specified number of non-zero grid cells,
randomly distributed throughout the raster. Each sampled cell will have a
unique value from 1 to num_samples, with background cells set to zero.
}
\details{
This tool is useful for statistical analyses of raster data where a random
sampling approach is needed. The sampling process only considers valid,
non-NoData cells from the input raster.
}
\examples{
f <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(f) |>
  wbw_random_sample(num_samples = 100)
}
\references{
For more information, see \url{https://www.whiteboxgeo.com/manual/wbw-user-manual/book/tool_help.html#random_sample}
}
\keyword{math}
