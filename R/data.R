#' Biomass of North East arctic cod
#'
#' A dataset containing time series of the spawning stock biomass
#' of the NorthEast artic cod stock between 1946 and 2016
#'
#' @format A data frame with 71 rows (corresponding to 71 years) and 4 variables:
#' \describe{
#'   \item{Year}{Year of the measurment}
#'   \item{Biomass}{Spawning stock biomass, in tonnes?}
#'   \item{Fishing}{Fishing pressure estimated by ...}
#'   \item{Temperature}{Temperature from ... in degree celsius}
#' }
#' @source ICESstock assessment?? \url{https://www.ices.dk/}
#' @references If any

"codnea"


#' Ecosystem state of the North Sea
#'
#' A dataset containing time series of the North Sea community state index from 1985 to 2019.
#' It was built performing a PCA on a matrix of data coming from the
#' Continuous Plankton Recorder (CPR) and International Bottom Trawl Survey (IBTS)
#' The Temperature is the sea surface temperature (expressed in degree C)
#' derived from NOAA ErSST v5 and fishing effort (expressed as hours swept per year)
#' from Couce at al. 2019.
#'
#' @format A data frame with 29 rows (corresponding to 29 years) and 4 variables:
#' \describe{
#'   \item{Year}{Year of the measurment}
#'   \item{PC1}{Ecosystem state from a PCA on fish and plankton biomass}
#'   \item{Fishing}{Fishing pressure estimated by Couce et al. 2019, in hours}
#'   \item{Temperature}{Temperature from NOAA ErSST v5 in degree celsius}
#' }
#' @source Sguotti et al., 2022
#' @references Couce et al. 2019

"ecosystem_ns"
