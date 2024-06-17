## Cusp Resilience Assessment

R package that ecological quantifies resilience from empirical data. Resilience is estimated based on the stochastic cusp model which allows the integration of multiple drivers and their interactions.  
This is the companion R-package to :  

Sguotti C., Vasilakopoulos P., Tzanatos E. and Frelat R. (2024) "Resilience assessment in complex natural systems". *Proc. R. Soc. B.* 291: 20240089 [DOI 10.1098/rspb.2024.0089](http://doi.org/10.1098/rspb.2024.0089)


**Installation**  

To install the R package, make sure the package `devtools` is install and type:  

` devtools::install_github(repo = "rfrelat/cuspra", dependencies = TRUE, build_vignettes = TRUE)`


**Tutorial**  

The tutorial can be seen [here](https://rfrelat.github.io/cuspra.html) or directly in R:   

`vignette("cuspra")`


**Interactive dashboard**  

An interactive dashboard is available [online](https://rfrelat.shinyapps.io/CUSPRA/), or in R:  

`cuspra::runShiny()`






[![DOI](https://zenodo.org/badge/320605700.svg)](https://zenodo.org/badge/latestdoi/320605700)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)



