#' Evaluation of the CUSP model vs linear model
#'
#' This function automatically return values to
#' pre-validate the cusp model
#' @param fitcusp output of the cusp() function
#' @return A data.frame with
#' \describe{
#'   \item{rsquared}{the pseudo R2 of the cusp model (should be >0.3)}
#'   \item{delta.aicc}{the minimum difference between AICc of the linear model and cusp model (should be >0)}
#'   \item{percin}{percentage of points within the cusp area (should be >10)}
#'   \item{pval.state}{p-value of the state variable (should be <0.05)}
#' }
#' @export
#' @examples
#' data(ecosystem_ns)
#' fitc <- cusp(y ~ PC1, alpha ~ Fishing,
#'             beta ~ Temperature,  data=ecosystem_ns)
#' evalcusp(fitc)
#'
evalcusp <- function(fitcusp){
  # calculate percentage of points in the cusp area
  cuspalpha <- 2 * (fitcusp$linear.predictors[, "beta"]/3)^(3/2)
  inalpha <- (abs(fitcusp$linear.predictors[, "alpha"]) - cuspalpha) <0
  inbeta <- fitcusp$linear.predictors[, "beta"]>0
  incusparea <- inalpha & inbeta
  percin <- sum(incusparea)/length(incusparea)*100

  #logistic model is not yet stable
  # sfit <- suppressWarnings(summary(fitcusp, logist = TRUE))
  # daicc <- min(c(sfit$r2lin.aicc - sfit$r2cusp.aicc,
  #                sfit$r2log.aicc - sfit$r2cusp.aicc),
  #              na.rm=TRUE)

  sfit <- summary(fitcusp)

  daicc <- sfit$r2lin.aicc - sfit$r2cusp.aicc

  pstate <- sfit$coefficient[6,4]

  return(data.frame(
    "rsquared"=sfit$r2cusp.r.squared,
    "delta.aicc"= daicc,
    "percin"=percin,
    "pval.state"=pstate))
}




#' Chi square test of linear vs CUSP model
#'
#' This function compute the p-value comparing
#' the linear vs cusp model using Chi-square test (likelihood-ratio test)
#' @param fitcusp output of the cusp() function
#' @return the chi-square values of the likelihood-ratio test
#' @export
#' @examples
#' data(ecosystem_ns)
#' fitc <- cusp(y ~ PC1, alpha ~ Fishing,
#'             beta ~ Temperature,  data=ecosystem_ns)
#' chi2pvalue(fitc)
#'
chi2pvalue <- function(fitcusp){
  #inspiration from
  # getS3method("print", "summary.cusp")
  sfit <- summary(fitcusp)
  chi2 = abs(-2 * (sfit$r2lin.logLik - sfit$r2cusp.logLik))
  chi2df = abs(sfit$r2lin.npar - sfit$r2cusp.npar)
  pvalue <- 1 - stats::pchisq(chi2, chi2df)
  return(data.frame("Xsquared"=chi2,
                    "df"=chi2df,
                    "pvalue"=pvalue))
}
