## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load---------------------------------------------------------------------
library(cusp)
library(cuspra)

## ----data---------------------------------------------------------------------
data("ecosystem_ns")
# or 
# data("fishtraits_med")
# data("cod_nea") 

## ----cusp---------------------------------------------------------------------
fitNS <- cusp(y ~ PC1, alpha ~ Fishing,
             beta ~ Temperature,  data=ecosystem_ns)
# Make sure to check the model results
# with summary(), evalcusp(), or visually with plot()
evalcusp(fitNS)

## ----cuspra-------------------------------------------------------------------
raNS <- cuspra(fitNS)

## ----fig.show='hold'----------------------------------------------------------
layout(matrix(c(2,1,1), ncol=1))
pal <- plotra(raNS$cuspRA, fitNS)
par(mar=c(2,4,1,1))
plot(ecosystem_ns$Year, ecosystem_ns$PC1, pch=16,
     ylab="State variable", type="b",
     col=as.character(cut(raNS$cuspRA, breaks = pal$bk, labels = pal$pal)))

