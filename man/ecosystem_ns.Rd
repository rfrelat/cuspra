% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{ecosystem_ns}
\alias{ecosystem_ns}
\title{Ecosystem state of the North Sea}
\format{
A data frame with 29 rows (corresponding to 29 years) and 4 variables:
\describe{
  \item{Year}{Year of the measurement}
  \item{PC1}{Ecosystem state from a PCA on fish (from the International Bottom Trawl Survey) and plankton (from the Continuous Plankton Recorder) abundances}
  \item{Fishing}{Fishing pressure estimated by Couce et al. 2019, in hours}
  \item{Temperature}{Temperature from NOAA ErSST v5 in degree celsius}
}
}
\source{
Couce, E., Schratzberger, M. & Engelhard, G. Reconstructing three decades of total international trawling effort in the North Sea. Earth System Science Data Discussions 1–19 (2019) doi:10.5194/essd-2019-90.
}
\usage{
ecosystem_ns
}
\description{
A dataset containing time series of the North Sea community state index from 1985 to 2019.
It was built performing a PCA on a matrix of data coming from the
Continuous Plankton Recorder (CPR) and International Bottom Trawl Survey (IBTS)
The Temperature is the sea surface temperature (expressed in degree C)
derived from NOAA ErSST v5 and fishing effort (expressed as hours swept per year)
from Couce at al. 2019.
}
\references{
Sguotti, C. et al. Irreversibility of regime shifts in the North Sea. Front Mar Sci 9, 1830 (2022).
}
\keyword{datasets}
