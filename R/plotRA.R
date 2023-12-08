#' Plot Resilience landscape
#'
#' This function plot the resilience landscape
#' based on the output of the cuspra function
#' and the plotting function from cusp package.
#' @param var output of the cusp() function
#' @param fitcusp output of the cusp() function
#' @param pal output of the cusp() function
#' @param main title of the plot
#' @param ... other arguments sent to plotCuspBifurcation
#' @keywords resilience assessment
#' @import graphics
#' @export
#' @examples
#' data(ecosystem_ns)
#' fitc <- cusp(y ~ PC1, alpha ~ Fishing,
#'             beta ~ Temperature,  data=ecosystem_ns)
#' ra <- cuspra(fitc)
#' plotra(ra$cuspRA, fitc)
#'
plotra <- function(var, fitcusp,
                        pal = rev(grDevices::terrain.colors(11))[-1],
                        main = "",
                        ...){

  if (min(var)>=0 & max(var)<=1){
    bkpal <- seq(0, 1, length.out = length(pal)+1)
  } else {
    bkpal <- seq(min(var), max(var), length.out = length(pal)+1)
  }
  coli<-as.character(cut(var, bkpal, labels = pal, include.lowest = TRUE))
  cusp::plotCuspBifurcation(fitcusp, col=coli, ...)
  graphics::mtext(main)
  invisible(list("bk"=bkpal, "pal"=pal))
}
