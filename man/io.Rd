% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{wbw_read_raster}
\alias{wbw_read_raster}
\alias{wbw_read_vector}
\title{Read Raster File as WhiteboxRaster}
\usage{
wbw_read_raster(file_name)

wbw_read_vector(file_name)
}
\arguments{
\item{file_name}{\code{character}, path to ESRI shapefile}
}
\value{
WhiteboxRaster object

WhiteboxVector object
}
\description{
Creates a new WhiteboxRaster object by reading raster data from a file
into memory.

Creates a new WhiteboxVector object by reading vector data from an ESRI
shapefile into memory.
}
\examples{
f <- system.file("extdata/dem.tif", package = "wbw")
wbw_read_raster(f)

}
\keyword{io}
