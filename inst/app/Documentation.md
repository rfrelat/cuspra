## Run CUSPRA on your dataset

The method is fully described in [Sguotti et al. (2024)](https://doi.org/10.1098/rspb.2024.0089). There are three successive steps:


### 1. Fit the stochastic CUSP model to your data

For more information about CUSP, see Petraitis and Dudgeon 2016 or Sguotti et al. 2019.

In short, CUSP considers three variables, one state variable and two exogenous variables: $\alpha$​ and $\beta$​. $\alpha$​ is the asymmetry variable, assumed to be linearly related to the state variable. $\beta$​ is the bifurcation variable, determining whether the state variable follows a continuous or discontinuous path.

The output is a 3D folded landscape which is often summarized as a two dimensional plane of {alpha, beta} with the bifurcation set indicating the discontinuous path.



### 2. Estimate the resilience from the folding landscape

The resilience is estimated from the two dimensional plane as the distance to the bifurcation set. The resilience is high when the observed $(\alpha, \beta)$ are far from the bifurcation set, while the resilience is low when $(\alpha, \beta)$​ are within the bifurcation set.


By definition, the bifurcation set is defined by:

$${\alpha}_{bif}= 2* \frac{\beta}{3}^{2/3}$$​ 	if $\beta >0$​

$${\alpha}_{bif}=0$$​ 					if $\beta <0$​



We defined the horizontal component​​ as:

$$H= \lvert\alpha\rvert-{\alpha}_{bif}$$​​​

$H$ is negative when inside the bifurcation set ($\lvert\alpha\rvert <{\alpha}_{bif}$​) and positive when outside the bifurcation set.



The vertical component is the distance to linearity, simply:   

$$V= -\beta$$

$V$ is negative when highly discontinous and positive when linear ($\beta<0$​)

The resilience (RA) is the weighted average between the horizontal and the vertical component, with double weight to the horizontal component. 

$$RA=\frac{2*H + V}{3}$$

Highly negative $d$ indicates a highly discontinuous system in the bifurcation set, while highly positive values indicate a linear system far from the bifurcation set. We transformed this resilience value $d$ to get an indicator $CUSPRA$ between 0 and 1, with 0 reflecting low resilience and 1 high resilience. 

$$CUSPRA = (\tanh(d))+1)/2$$  


### 3. Interpretation of the output of CUSPRA

A low $CUSPRA$ (value close to 0) means a system that is unstable, where large changes in state can happen with little changes in the stressor variables. On the contrary, a large CUSPRA (close to 1) indicates a system that is mostly linear in regard to the $\alpha$ variable.



## Simulations

For the simulation, the state variables are randomly generated from a CUSP model with given alpha and beta variables.

You can chose how to randomly generate alpha and beta variables, either using autocorrelation (AR1 process) or from a Guassian distribution (with given average and standard deviation). 



## References

Petraitis PS, Dudgeon SR. 2016 Cusps and butterflies: multiple stable states in marine systems as catastrophes. Mar. Freshw. Res. 67, 37–46 (doi:10.1071/MF14229)

Sguotti C, Otto SA, Frelat R,  Langbehn TJ, Ryberg MP, Lindegren M, ... & Möllmann C (2019). Catastrophic dynamics limit Atlantic cod recovery. *Proceedings of the Royal Society B*, *286*(1898), 20182877.  

Sguotti C, Vasilakopoulos P, Tzanatos E, Frelat R (2024). Resilience  assessment in complex natural systems. *Proceedings of the Royal Society B*, 291(2023), (20240089). doi:[10.1098/rspb.2024.0089](https://doi.org/10.1098/rspb.2024.0089).
