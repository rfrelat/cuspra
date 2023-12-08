library(shiny)
library(cusp)
library(cuspra)


shinyServer(function(input, output, session) {

  info <- eventReactive(input$choice, {
    inFile <- input$file

    req(inFile) # == if (is.null(inFile))

    # Changes in read.table
    f <- read.table(inFile$datapath, header = input$header,
                    sep = input$sep)
    vars <- names(f)
    vars <- vars[!tolower(vars)%in%c("year", "yr", "years")]

    # Update select input immediately after clicking on the action button.
    updateSelectInput(session, "state","Select State variable",
                      choices = vars, selected = vars[1])
    updateSelectInput(session, "stA","Select Stressor alpha",
                      choices = vars, selected = vars[2])
    updateSelectInput(session, "stB","Select Stressor beta",
                      choices = vars, selected = vars[3])
    f
  })

  output$showCUSP <- renderPlot({
    f <- info()

    req(input$state)

    df <- data.frame("y"=as.numeric(f[,input$state]),
                     "alpha"=as.numeric(f[,input$stA]),
                     "beta"=as.numeric(f[,input$stB]))
    # cusp model#
    fit_community <-  cusp(y ~ y, alpha ~ alpha, beta ~ beta,  data=df)
    # cuspra
    ra <- cuspra(fit_community, warn = FALSE)

    # output

    layout(matrix(c(1,1,4,1,1,4,2,3,4), ncol=3))

    colpal <- plotra(ra$cuspRA, fit_community,
                                    main="Resilience")

    # lines(fit_community$linear.predictors$alpha,
    #       fit_community$linear.predictors$beta, col="darkgrey", lty=3)
    par(mar=c(2,2,2,1))
    plot(1:nrow(df), df$alpha, type="l", main=paste("Alpha:",input$stA), ylab="")
    plot(1:nrow(df), df$beta, type="l", main=paste("Beta:",input$stB), ylab="")
    par(mar=c(3,4,2,1))
    cols <- as.character(cut(ra$cuspRA, colpal$bk, colpal$pal))
    plot(1:nrow(df), df$y, type="l", main=paste("State:",input$state), ylab="")
    points(1:nrow(df), df$y, pch=15, col=cols)
  })

  output$evalCUSP <- renderUI({
    req(input$state)
    f <- info()
    df <- data.frame("y"=as.numeric(f[,input$state]),
                     "alpha"=as.numeric(f[,input$stA]),
                     "beta"=as.numeric(f[,input$stB]))
    fit_community <-  cusp(y ~ y, alpha ~ alpha, beta ~ beta,  data=df)
    eval <- evalcusp(fit_community)
    txt <- c(paste("R2=", round(eval$rsquared,2), " (should be >0.3)"),
             paste("difference AICc=", round(eval$delta.aicc,1), " (should be >0)"),
             paste("% points in cusp area=", round(eval$percin,1), " (should be >10)"),
             paste("p-value of state variable=", round(eval$pval.state,4), " (should be <0.05)"))
    return(HTML(paste(txt,collapse = '<br/>')))
  })

  output$simuPlot <- renderPlot({

    # Create alpha sequences
    if (input$alptype=="ar"){
      ts_alpha <- as.numeric(arima.sim(n=input$nstep, list(ar=input$alpar)))
      lab_alpha <- paste0("Alpha, AR1=",input$alpar)
    } else {
      ts_alpha <- rnorm(input$nstep, input$alpu, sd = input$alpsd)
      lab_alpha <- paste0("Alpha, u=",input$alpu, ", sd=", input$alpsd)
    }

    # Create beta sequences
    if (input$bettype=="ar"){
      ts_beta <- as.numeric(arima.sim(n=input$nstep, list(ar=input$betar)))
      lab_beta <- paste0("Beta, AR1=",input$betar)
    } else {
      ts_beta <- rnorm(input$nstep, input$betu, sd = input$betsd)
      lab_beta <- paste0("Beta, u=",input$betu, ", sd=", input$betsd)
    }

    # Simulate cusp state variable based on alpha and beta
    ts_y <- Vectorize(rcusp)(1, ts_alpha, ts_beta)

    # Organize the simulated data in data. frame
    lpred <- data.frame("alpha"=ts_alpha,
                        "beta"=ts_beta)

    dfu <- list("y"=ts_y,
                "linear.predictors"=lpred)

    #Compute the CUSPRA
    cuspu <- cuspra(dfu, warn = FALSE)

    # set the name of the simulation
    # labru <- paste0("U",u,"_AR",ar1,"_N",r)

    layout(matrix(c(1,1,4,1,1,4,2,3,4), ncol=3))

    colpal <- plotra(cuspu$cuspRA, dfu,
                              main="Resilience")
    lines(dfu$linear.predictors$alpha,
          dfu$linear.predictors$beta, col="darkgrey", lty=3)
    par(mar=c(2,2,2,1))
    plot(1:input$nstep, ts_alpha, type="l", ylab="alpha")
    mtext(lab_alpha, side=3, cex = 0.7)
    plot(1:input$nstep, ts_beta, type="l")
    mtext(lab_beta, side=3, cex = 0.7)
    par(mar=c(3,4,2,1))
    cols <- as.character(cut(cuspu$cuspRA, colpal$bk, colpal$pal))
    plot(1:input$nstep, ts_y, type="l", main="Simulated state", ylab="")
    points(1:input$nstep, ts_y, pch=15, col=cols)
  })

  output$renderedReport <- renderUI({
    includeHTML('Documentation.html')
  })
})
