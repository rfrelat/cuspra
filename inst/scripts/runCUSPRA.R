# script to run the CUSPRA on empirical dataset

# To install the latest cuspra version, use the devtools package
# devtools::install_github(repo = "rfrelat/cuspra", build_vignettes = TRUE)
library(cusp)
library(cuspra)


# Example on North Sea benthic community ------------------
# 1. Load the dataset
data(ecosystem_ns)
# or you could load one of the other dataset
# data(fishtraits_med)
# data(cod_nea)
# in the case of North sea cod, replace PC1 with Biomass in the cusp()


# 2. Fit the cusp model
fitNS <- cusp(y ~ PC1, alpha ~ Fishing,
             beta ~ Temperature,  data=ecosystem_ns)
# Make sure to check the model results
# with summary(), evalcusp(), or visually with plot()
evalcusp(fitNS)


# 3. Estimate the resilience
raNS <- cuspra(fitNS)


# 4. Visualize the results
layout(matrix(c(2,1,1), ncol=1))
pal <- plotra(raNS$cuspRA, fitNS)
par(mar=c(2,4,1,1))
plot(ecosystem_ns$Year, ecosystem_ns$PC1, pch=16,
     ylab="State variable", type="b",
     col=as.character(cut(raNS$cuspRA, breaks = pal$bk, labels = pal$pal)))



