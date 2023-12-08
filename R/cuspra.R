#' Resilience Assessment of the CUSP output
#'
#' This function compute the resilience assessment based
#' on the output of cusp function
#' @param fitcusp output of the cusp() function
#' @param walpha weight of the horizontal distance (default=2). The weight of vertical distance is always 1.
#' @param warn define if warnings are shown when the cusp model seems unreliable (default=TRUE)
#' @keywords resilience assessment
#' @export
#' @examples
#' data(ecosystem_ns)
#' fitc <- cusp(y ~ PC1, alpha ~ Fishing,
#'             beta ~ Temperature,  data=ecosystem_ns)
#' ra <- cuspra(fitc)
#'
cuspra <- function(fitcusp, walpha=2, warn = TRUE){
  # warnings on CUSP validity
  if (warn){
    efit <- evalcusp(fitcusp)
    if (efit$rsquared<0.3){
      warning("The pseudo R.squared of the cusp model is abnormally low.")
    }
    if (efit$delta.aicc<0){
      warning("The cusp model do not pass the AICc test.")
    }
    if (efit$percin<10){
      warning("Less than 10% of points are in the cusp area.")
    }
    if (efit$pval.state>0.05){
      warning("The p-value of the state variable is not significant.")
    }
  }

  # vertical distance with to one vs two state
  beta <- fitcusp$linear.predictors[, "beta"]
  dbeta <- - beta

  # distance from unstable area
  alpha <-  2 * (beta/3)^(3/2)
  alpha[is.nan(alpha)] <- 0
  dalpha <- (abs(fitcusp$linear.predictors[, "alpha"]) - alpha)

  #Resilience
  #sum of the distances
  sumd <- (walpha*dalpha + dbeta)/(walpha+1)
  # between 0 and 1
  cuspRA <- (tanh(sumd)+1)/2

  res <- data.frame("cuspRA"=cuspRA,
                    "dalpha"=dalpha,
                    "dbeta"=dbeta,
                    "sumd"=sumd)
  return(res)
}

