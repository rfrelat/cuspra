% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cuspra.R
\name{cuspra}
\alias{cuspra}
\title{Resilience Assessment of the CUSP output}
\usage{
cuspra(fitcusp, walpha = 2, warn = TRUE)
}
\arguments{
\item{fitcusp}{output of the cusp() function}

\item{walpha}{weight of the horizontal distance (default=2). The weight of vertical distance is always 1.}

\item{warn}{define if warnings are shown when the cusp model seems unreliable (default=TRUE)}
}
\value{
A data.frame with
\describe{
  \item{cuspRA}{the resilience assessment, with values between 0 (low resilience) and 1 (high resilience)}
  \item{dalpha}{the horizontal component as distance to the cusp area (if negative, the point is inside the cusp area)}
  \item{dbeta}{the vertical component as distance to linearity (if negative the system is discontinuous)}
  \item{sumd}{the weighted average of the horizontal and vertical components (by default the horizontal component has double weight, walpha=2)}
}
}
\description{
This function compute the resilience assessment based
on the output of cusp function
}
\examples{
data(ecosystem_ns)
fitc <- cusp(y ~ PC1, alpha ~ Fishing,
            beta ~ Temperature,  data=ecosystem_ns)
ra <- cuspra(fitc)

}
\keyword{assessment}
\keyword{resilience}
