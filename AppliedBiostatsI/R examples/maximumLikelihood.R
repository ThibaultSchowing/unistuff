### MAXIMUM LIKELIHOOD ESTIMATION
### @author Alain Hauser <alain.hauser@bfh.ch>
### @date 2014-10-20

###################################################
## Poisson distribution
babyboom <- read.table("../data/babyboom.dat", header = TRUE)
birthtime <- floor(babyboom$minute/60)
x <- sapply(0:23, function(i) sum(birthtime == i))
bph.hist <- hist(x, freq = FALSE, xlab = "k", main = "", breaks = 0:7 - 0.5)

lambda.hat <- mean(x)

# Q-Q plot
library(car)
qqPlot(x, dist = "pois", lambda = lambda.hat, 
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "Q-Q plot")

# Confidence interval
lambda.se <- sd(x)/sqrt(length(x))
lambda.ci <- c(lambda.hat - qnorm(0.975)*lambda.se,
               lambda.hat + qnorm(0.975)*lambda.se)


###################################################
## Normal distribution
x <- babyboom$weight
(est.mean <- mean(x))
(est.sd <- sd(x)*sqrt(23/24))
qqPlot(x, dist = "norm", 
  mean = est.mean, sd = est.sd)

###################################################
## Log-transform
plomb <- scan("../data/blei.dat")

# Q-Q plot for plomb concentration vs. normal distribution
qqPlot(plomb, dist = "norm", mean = mean(plomb), sd = sd(plomb),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "not transformed")
# Q-Q plot for log-transformed plomb concentration vs. normal distribution
qqPlot(log(plomb), dist = "norm", mean = mean(log(plomb)), sd = sd(log(plomb)),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "log-transformed")


###################################################
## Exponential distribution
x <- diff(babyboom$minute)
(rate <- 1/mean(x))
qqPlot(x, dist = "exp", rate = 1/i.mean,
       xlab = "Theoretical quantiles", ylab = "Empirical quantiles", main = "Q-Q plot")


