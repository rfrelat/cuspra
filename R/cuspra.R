#' Resilience Assessment of the CUSP output
#'
#' This function compute the resilience assessment based
#' on the output of cusp function
#' @param fitcusp output of the cusp() function
#' @keywords resilience assessment
#' @export
#' @examples
#' data(codnea)
#' fitc <- cusp(y ~ Biomass, alpha ~ Fishing,
#'             beta ~ Temperature,  data=codnea)
#' ra <- cuspra(fitc)
#'
cuspra <- function(fitcusp){
  # vertical distance with to one vs two state
  beta <- fitcusp$linear.predictors[, "beta"]
  dbeta <- - beta

  # distance from unstable area
  alpha <-  2 * (beta/3)^(3/2)
  alpha[is.nan(alpha)] <- 0
  dalpha <- (abs(fitcusp$linear.predictors[, "alpha"]) - alpha)

  #Resilience
  #sum of the distances
  sumd <- (2*dalpha + dbeta)/3
  # between 0 and 1
  cuspRA <- (tanh(sumd)+1)/2

  res <- data.frame("cuspRA"=cuspRA,
                    "dalpha"=dalpha,
                    "dbeta"=dbeta,
                    "sumd"=sumd)
  return(res)
}
