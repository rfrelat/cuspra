#' Biomass of North East arctic cod
#'
#' A dataset containing time series of the spawning stock biomass
#' of the North-East Artic Sea cod stock between 1946 and 2016
#'
#' @format A data frame with 71 rows (corresponding to 71 years) and 4 variables:
#' \describe{
#'   \item{Year}{Year of the measurement}
#'   \item{Biomass}{Spawning stock biomass data deriving from stock assessment}
#'   \item{Fishing}{Fishing mortality estimated by stock assessment}
#'   \item{Temperature}{Temperature from NOAA ErSST v5 in degree celsius}
#' }
#' @source Sguotti, C. et al. 2019
#' @references Sguotti, C. et al. Catastrophic dynamics limit Atlantic cod recovery. Proceedings of the Royal Society B 286, (2019).
"cod_nea"


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
#'   \item{Year}{Year of the measurement}
#'   \item{PC1}{Ecosystem state from a PCA on fish (from the International Bottom Trawl Survey) and plankton (from the Continuous Plankton Recorder) abundances}
#'   \item{Fishing}{Fishing pressure estimated by Couce et al. 2019, in hours}
#'   \item{Temperature}{Temperature from NOAA ErSST v5 in degree celsius}
#' }
#' @source  Couce, E., Schratzberger, M. & Engelhard, G. Reconstructing three decades of total international trawling effort in the North Sea. Earth System Science Data Discussions 1–19 (2019) doi:10.5194/essd-2019-90.
#' @references Sguotti, C. et al. Irreversibility of regime shifts in the North Sea. Front Mar Sci 9, 1830 (2022).
"ecosystem_ns"


#' Traits of landings of Mediterranean Sea fish
#'
#' This dataset was derived by combining the Mediterranean fisheries landings data
#' of the FAO for the years 1985–2015 with a matrix including data on 23 traits
#' related to the biology, ecology, trophic role, distribution, habitat and behaviour
#' of 205 species (mostly fish, but also mollusks and crustaceans).
#' The multiplication of the two datasets resulted into a matrix of
#' community weighted mean traits landings by year in the Mediterranean Sea that was analysed in a PCA.
#'
#' @format A data frame with 71 rows (corresponding to 71 years) and 4 variables:
#' \describe{
#'   \item{Year}{Year of the measurement}
#'   \item{PC1}{PC1 of the community weighted mean traits of the landings}
#'   \item{Fishing}{Fishing capacity estimated for the entire Mediterranean Sea by FAO}
#'   \item{Temperature}{Sea surface temperature from the NASA PODAAC}
#' }
#' @source FAO Mediterranean fisheries landings \url{http://www.fao.org/fishery/statistics/GFCM-capture-production/en}
#' @references Tsimara, E. et al. An Integrated Traits Resilience Assessment of Mediterranean fisheries landings. Journal of Animal Ecology 90, 2122–2134 (2021).
#' @references Koutsidi, M. et al. (2019). 23 biological traits of 235 species. figshare. Dataset. https://doi.org/10.6084/m9.figshare.11347406.v1
"fishtraits_med"
