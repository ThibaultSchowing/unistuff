library(shiny)

###########################################################
## Shiny app (server part) to visualize a t test
## 
## @author Alain Hauser <alain.hauser@bfh.ch>
## @date 2015-11-09
###########################################################

shinyServer(function(input, output) {
    
  output$tStatPlot <- renderPlot({
    x <- seq(-6, 6, length.out = 501)
    plot(x, dt(x, df = input$n - 1), type = "l",
         ylim = c(-0.5, 0.5), xlab = "t", ylab = "f(t)", main = "")
    
    # Test statistic
    t <- sqrt(input$n)*(input$xbar - input$mu0)/input$sx
    alpha <- input$alpha/100
    
    if (input$show == "reject") {
      # Rejection range
      if (input$alternative == "two.sided") {
        c.lwr <- qt(alpha/2, df = input$n - 1)
        c.upr <- - c.lwr
      }
      if (input$alternative == "less") {
        c.lwr <- qt(alpha, df = input$n - 1)
        c.upr <- 9
      }
      if (input$alternative == "greater") {
        c.lwr <- -9
        c.upr <- qt(1 - alpha, df = input$n - 1)
      }
      col.reject <- colorRamp(c("white", "orange"))
      arrows(-10, -0.1, c.lwr, -0.1, angle = 90, code = 2,
             col = "orange", lwd = 2)
      arrows(c.upr, -0.1, 10, -0.1, angle = 90, code = 1,
             col = "orange", lwd = 2)
      if (length(x.fill <- x[x <= c.lwr]) > 0) {
        polygon(c(x.fill[1], x.fill, tail(x.fill, 1)), 
                c(0, dt(x.fill, df = input$n - 1), 0), 
                col = col.reject(0.4))
      }
      if (length(x.fill <- x[x >= c.upr]) > 0) {
        polygon(c(x.fill[1], x.fill, tail(x.fill, 1)), 
                c(0, dt(x.fill, df = input$n - 1), 0), 
                col = col.reject(0.4))
      }
    } else {
      # p-value
      if (input$alternative %in% c("two.sided", "less")) {
        a <- t
        if (input$alternative == "two.sided") {
          a <- -abs(t)
        }
        if (length(x.fill <- x[x <= a]) > 0) {
          polygon(c(x.fill[1], x.fill, a, a), 
                  c(0, dt(c(x.fill, a), df = input$n - 1), 0), 
                  col = "skyblue")
        }
      } 
      if (input$alternative %in% c("two.sided", "greater")) {
        a <- t
        if (input$alternative == "two.sided") {
          a <- abs(t)
        }
        if (length(x.fill <- x[x >= a]) > 0) {
          polygon(c(a, a, x.fill, tail(x.fill, 1)), 
                  c(0, dt(c(a, x.fill), df = input$n - 1), 0), 
                  col = "skyblue")
        }
      } 
    }
    
    # Test statistic
    segments(t, -0.05, t, dt(t, df = input$n - 1) + 0.05, lwd = 2, col = "red")
    
    # Legend
    legend("bottomright", bty = "n",
           lty = 1,
           lwd = 2,
           col = c("red", "orange", "skyblue"),
           legend = c("Value of T for sample", "Range of rejection", "p-value"))
  })
  
  output$confidencePlot <- renderPlot({
    alpha <- input$alpha/100
    
    x <- seq(-5, 5, length.out = 501)
    plot(x, dnorm(x, mean = input$mu0, sd = input$sx/sqrt(input$n)), type = "l",
         ylim = c(-1, 1.5), xlab = expression(bar(x)), ylab = "", main = "")
    
    segments(input$xbar, -0.1, input$xbar, 0.1, lwd = 2, col = "red")
    
    # Confidence interval
    if (input$alternative == "two.sided") {
      ci.lwr <- input$xbar - qt(1 - alpha/2, df = input$n - 1)*input$sx/sqrt(input$n)
      ci.upr <- input$xbar + qt(1 - alpha/2, df = input$n - 1)*input$sx/sqrt(input$n)
    } else if (input$alternative == "less") {
      ci.lwr <- -10
      ci.upr <- input$xbar + qt(1 - alpha, df = input$n - 1)*input$sx/sqrt(input$n)
    } else if (input$alternative == "greater") {
      ci.lwr <- input$xbar - qt(1 - alpha, df = input$n - 1)*input$sx/sqrt(input$n)
      ci.upr <- 10
    }
    
    arrows(ci.lwr, -0.2, ci.upr, -0.2, angle = 90, code = 3,
           lwd = 2, col = "green")
    
    # Legend
    legend("bottomright", bty = "n",
           lty = 1, lwd = c(1, 2, 2), col = c("black", "red", "green"),
           legend = c("Distribution of sample mean under H0", "Measured sample mean", "Confidence interval for μ"))
  })
})
