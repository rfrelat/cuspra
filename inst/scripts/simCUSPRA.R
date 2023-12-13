library(cuspra)
library(cusp)

#Artificial data --------------------------------
alp <- seq(-2, 2, by=0.1)
bet <- seq(-2, 2, by=0.1)
lpred <- data.frame("alpha"=rep(alp, length(bet)),
                    "beta"=rep(bet, each=length(bet)))

#Add y value (no effect on cuspra value)
fit1 <- list("y"=1,
                "linear.predictors"=lpred)
test1 <- cuspra(fit1, warn=FALSE)

par(mfrow=c(2,2), mar=c(4,4,1,1), oma=c(0,1,0,0))
colpal <- plotra(test1$cuspRA, fit1,
                          main="Resilience")
boxplot(test1$cuspRA, ylab="Resilience")
xseq <- colpal$bk
rect(0, xseq[-length(xseq)], 0.5, xseq[-1],
     col=colpal$pal)
plotra(test1$dalpha, fit1,
       main="horizontal distance")
plotra(test1$dbeta, fit1,
       main="vertical distance")



# 2. Make simulations ---------------------------
# alpha follows a strong AR1 process (e.g. linear trend)
# created with arima.sim()
# beta follows a normal distribution of mean u
# created with rnorm()

# parameters
set.seed(24) #for reproducibility
nstep <- 50 #length of time series
useq <- seq(-2,2, by=1) # mean level of beta
ar1 <- 0.9 # autocorrelation level
nrep <- 10 # number of repetition per scenario

drawplot <- FALSE
resSimu <- list() #list to store all simulations
for (u in useq){
  for (r in 1:nrep){

    # Create alpha sequences
    ts_alpha <- as.numeric(arima.sim(n=nstep, list(ar=ar1)))
    # Create beta sequences
    ts_beta <- rnorm(nstep, u, sd = 0.5)

    # Simulate cusp state variable based on alpha and beta
    ts_y <- Vectorize(rcusp)(1, ts_alpha, ts_beta)

    # Organize the simulated data in data. frame
    lpred <- data.frame("alpha"=ts_alpha,
                        "beta"=ts_beta)

    dfu <- list("y"=ts_y,
                "linear.predictors"=lpred)

    #Compute the CUSPRA
    cuspu <- cuspra(dfu, warn=FALSE)

    #set the name of the simulation
    labru <- paste0("U",u,"_AR",ar1,"_N",r)

    #save the simulation in the list resSimu
    resSimu[[labru]] <- cbind(ts_alpha, ts_beta, ts_y, cuspu)

    #Plot
    if(drawplot){
      layout(matrix(c(1,1,4,1,1,4,2,3,4), ncol=3))

      colpal <- plotra(cuspu$cuspRA, dfu,
                       main="Resilience")
      lines(dfu$linear.predictors$alpha,
            dfu$linear.predictors$beta, col="darkgrey", lty=3)
      par(mar=c(2,2,2,1))
      plot(1:nstep, ts_alpha, type="l", ylab="alpha")
      mtext(paste0("Alpha, AR1=",ar1), side=3, cex = 0.7)
      plot(1:nstep, ts_beta, type="l")
      mtext(paste0("Beta, u=",u, ", sd=0.5"), side=3, cex = 0.7)
      par(mar=c(3,4,2,1))
      cols <- as.character(cut(cuspu$cuspRA, colpal$bk, colpal$pal))
      plot(1:nstep, ts_y, type="l", main="Simulated state", ylab="")
      points(1:nstep, ts_y, pch=15, col=cols)
    }
  }
}


# Summary of simulations
library(gridExtra)
library(ggplot2)

# A. minimum cuspra vs beta level

# get the beta level (u) per simulation
u <- as.numeric(substr(names(resSimu), 2, regexpr("_", names(resSimu))-1))

# get the minimum CUSPRA per simulation
mincuspra <- sapply(resSimu, function(x) min(x$cuspRA))

# compare the min CUSPRA with beta level u
par(mfrow=c(1,1), mar=c(4,4,1,1))
boxplot(mincuspra~u, xlab="U, beta level", ylab="min CUSPRA")

df1 <- data.frame("U.beta"=as.factor(u), "min CUSPRA"=mincuspra)
p1 <- ggplot(df1, aes(x=U.beta, y=min.CUSPRA)) +
  geom_boxplot()+ theme_classic()

# B. cuspra vs change level
absdiff <- sapply(resSimu, function(x) abs(diff(x$ts_y)))
cuspra <- sapply(resSimu, function(x) x$cuspRA[-length(x$cuspRA)])
# plot(as.vector(cuspra), as.vector(absdiff))
# lo <- loess.smooth(as.vector(cuspra), as.vector(absdiff))
# lines(lo, col='red', lwd=2)
df <- data.frame("delta"=as.vector(absdiff),
                 "cuspra"=as.vector(cuspra))
p2 <- ggplot(data = df, aes(x = cuspra, y = delta)) +
  geom_point(color = 'black') + theme_classic() +
  stat_smooth(level=0.99)

# C. cuspra vs variance
w <- 5
varW <- c()
cuspM <- c() #mean cuspra
for (i in resSimu){
  for (j in (1:(length(i$ts_y)-w+1))){
    varW <- c(varW, var(i$ts_y[j:(j+w-1)]))
    cuspM <- c(cuspM, mean(i$cuspRA[j:(j+w-1)]))
  }
}

dfV <- data.frame("variance"= varW, "cuspra"=cuspM)
p3 <- ggplot(data = dfV, aes(x = cuspra, y = variance)) +
  geom_point(color = 'black') + theme_classic()+
  stat_smooth()


grid.arrange(p1, p2, p3, ncol=3, nrow = 1)


# 3. Test of different data types ----------------------------------
#parameters
set.seed(42) #for reproducibility
per_freq <- 5 #number of period per time series
per_noise <- 0.3 #level of noise on the periodic variable
u0 <- 2 # high level of discontinuity
nrep <- 100 # number of repetitions

resTest <- list() #list to store all simulations
for (r in 1:nrep){

    # Create alpha sequences
    ts_alpha <- as.numeric(arima.sim(n=nstep, list(ar=ar1)))
    # Create beta sequences
    ts_beta <- rnorm(nstep, u0, sd = 0.5)

    # Simulate cusp state variable based on alpha and beta
    ts_y0 <- Vectorize(rcusp)(1, ts_alpha, ts_beta)
    # Simulate random periodic state variable
    ts_y1 <- sin(1:nstep/nstep*2*pi*per_freq)+rnorm(nstep, 0, sd = per_noise)
    # Simulate random state variable
    ts_y2 <- rnorm(nstep, 0, sd = 1)

    df0 <- list("y"=ts_y0,
                "alpha"=ts_alpha,
                "beta"=ts_beta)
    df1 <- list("y"=ts_y1,
                "alpha"=ts_alpha,
                "beta"=ts_beta)
    df2 <- list("y"=ts_y2,
                "alpha"=ts_alpha,
                "beta"=ts_beta)

    fit_0 <- cusp(y ~ y, alpha ~alpha, beta ~ beta,  data=df0)
    efit0 <- evalcusp(fit_0)
    pval0 <- chi2pvalue(fit_0)

    fit_1 <- cusp(y ~ y, alpha ~alpha, beta ~ beta,  data=df1)
    efit1 <- evalcusp(fit_1)
    pval1 <- chi2pvalue(fit_1)

    fit_2 <- cusp(y ~ y, alpha ~alpha, beta ~ beta,  data=df2)
    efit2 <- evalcusp(fit_2)
    pval2 <- chi2pvalue(fit_2)

    #save the simulation in the list resSimu
    new <- data.frame("sim"=c("cusp","periodic","random"),
                      "r2"=c(efit0$rsquared, efit1$rsquared, efit2$rsquared),
                      "deltaAIC"=c(efit0$delta.aicc, efit1$delta.aicc, efit2$delta.aicc),
                      "percin"=c(efit0$percin, efit1$percin, efit2$percin),
                      "pvalstate"=c(efit0$pval.state, efit1$pval.state, efit2$pval.state),
                      "pvalmodel"=c(pval0$pvalue, pval1$pvalue, pval2$pvalue))

    resTest <- rbind(resTest, new)
}


par(mfrow=c(5,1), mar=c(2,4,1,1))
plot(1:nstep, ts_alpha, type="l", main="Alpha", ylab="Alpha")
plot(1:nstep, ts_beta, type="l", main="Beta", ylab="Beta")
plot(1:nstep, ts_y0, type="l", main="Cusp simulation", ylab="Cusp simulated state")
plot(1:nstep, ts_y1, type="l", main="Periodic simulation", ylab="Periodic simulated state")
plot(1:nstep, ts_y2, type="l", main="Random simulation", ylab="Random simulated state")



par(mfrow=c(2,2), mar=c(4,4,1,1))
boxplot(resTest$r2 ~resTest$sim,
        ylab="Pseudo R-squared", xlab="Simulation")
abline(h=0.3, lwd=2, lty=3, col="red")

boxplot(resTest$deltaAIC ~resTest$sim,
        ylab="Delta AIC", xlab="Simulation")
abline(h=0, lwd=2, lty=3, col="red")

boxplot(resTest$percin ~resTest$sim,
        ylab="Percentage in cusp area", xlab="Simulation")
abline(h=10, lwd=2, lty=3, col="red")

boxplot(resTest$pvalstate ~resTest$sim, ylim=c(0,0.1),
        ylab="p-value state variable", xlab="Simulation")
abline(h=0.05, lwd=2, lty=3, col="red")


# see the test results
table(resTest$deltaAIC>0 &resTest$r2>0.3 &resTest$percin >=10 & resTest$pvalstate<0.05,
      resTest$sim)

