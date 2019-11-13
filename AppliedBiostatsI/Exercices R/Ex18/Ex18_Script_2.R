###########################################################################
###########################################################################
###                                                                     ###
###                         Exercise 18.                                ###
###                                                                     ###
###########################################################################
########################################################################### 


### Question:

hist(v1, breaks = 50, col = "cyan3", freq = F, xlab = "Health Care Cost [$]", main = "Have a look at the following histogram \n of monthly costs (in CHF) for health care of 200 patients:")

hist(v1, breaks = 50, col = "cyan3", freq = F, xlab = "Health Care Cost [$]", main = "Do you know a distribution that fits the data?")


### Install packages

install.packages(c("Mass","car", "fitdistrplus"))

### Required Packages for this Exercise
library("MASS")
library("car")
library("fitdistrplus")













###########################################################################
###########################################################################
###                                                                     ###
###                         Exercise 18.a                               ###
###                                                                     ###
###########################################################################
########################################################################### 



### Open the dataset:

v1 <- scan("health-care-cost.txt")

v1_mean <- mean(v1); v1_mean
v1_sd <- sd(v1); v1_sd



### Use fitdistr function from MASS, which allows Maximum-likelihood fitting of univariate distributions.
### The function returns estimated standard errors that are taken from the observed information.

fit_normal <- fitdistr(v1, "normal"); fit_normal

fit_exp <- fitdistr(v1, "exponential"); fit_exp


fit_normal2 <- fitdist(v1, pnorm, method = "mle"); fit_normal2

plot(fit_normal2)



### Make a qqPlot of different distribution types


### qqnorm from Base

qqnorm(v1)


qqplot(rnorm(1000), v1)


### qqPlot from Car package. This qqPlot function plots the central tendency and a confidence interval


qqPlot(v1, dist = "norm", col.lines = "firebrick2", envelope = 0.95,
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost",
       id = F)

## Histogram of a normal distribution
x_norm <- rnorm(100000, mean = 0, sd = 1)
layout(matrix(c(1,2), 2, 2, byrow = TRUE))
hist(v1, breaks = 50, col = "cyan3", freq = F, xlab = "Health Care Cost [$]", main = "Health Care Cost")
hist(x_norm, breaks = 100, freq = F, xlab = "x", col=rgb(1,0,0,1/2), main = "Histogram \n Normal Distribution")
graphics.off()

### Data doesnt look normally distributed. We can further check using the Shapiro Wilks Method:

shapiro.test(v1)

### The p-value is far below 0.05 implying that our distribution is significantly different from a normal distribution.


### Test other distribution of continuous variable: Exponential Distribution

qqPlot(v1, dist = "exp",
       col = "grey10", col.lines = "firebrick2", envelope = 0.95,
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost",
       id = F)

## Histogram of a exponential distribution
x_exp <- rexp(100000, rate = 1)
layout(matrix(c(1,2), 2, 2, byrow = TRUE))
hist(v1, breaks = 50, col = "cyan3", freq = F, xlab = "Health Care Cost [$]", main = "Health Care Cost")
hist(x_exp, breaks = 100, freq = F, xlab = "x", col=rgb(1,0,0,1/2), main = "Histogram \n Exponential Distribution")
graphics.off()

### We can see that the exponetial distribution fits the data better than the normal one.


### Test other distribution of continuous variable: Gamma Distribution

qqPlot(v1, dist = "gamma", shape = 2,
       col = "grey10", col.lines = "firebrick2",
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost",
       id = F)

## Histogram of a gamma distribution

x_g <- rgamma(100000,shape = 2,rate = 1)
layout(matrix(c(1,2), 2, 2, byrow = TRUE))
hist(v1, breaks = 50, col = "cyan3", freq = F, xlab = "Health Care Cost [$]", main = "Health Care Cost")
hist(x_g, breaks = 100, freq = F, xlab = "x", col=rgb(1,0,0,1/2), main = "Histogram \n Gamma Distribution")
graphics.off()

 
###########################################################################
###########################################################################
###                                                                     ###
###                         Exercise 18.b)                              ###
###                                                                     ###
###########################################################################
########################################################################### 

# Log transform the data
v1.log <- log(v1)

# Plot the log transformed data
hist(v1.log, breaks = 80, col = "light blue", border = "black", ylab = "Density", xlab = "Cost", ylim = c(0, 1.5) , main = "Monthly costs after a log-transformation \n of the data", freq = F)

# Fit to the normal distribution 
fit_normal_log <- fitdistr(v1.log, "normal"); fit_normal_log


# Displayed as density and not frequency, adding normal curve to see the match
x <- range(1, 7, 0.001)
# Plot against a normal distribuion
curve(dnorm(x, mean(v1.log), var(v1.log)), lwd=2, col="red", add = T)



# TODO !?!?!?!?
# Plot against the fitted distribution
curve(dnorm(x, fit_normal_log$estimate["mean"], sqrt(fit_normal_log$sd["sd"])), lwd=2, col="black", add = T)

legend("topright", c("Normal distribution", "Fitted distribution"), col=c("red", "black"), lwd=10)






#QQplot 

qqPlot(v1.log, dist = "norm", col.lines = "firebrick2", envelope = 0.95,
       ylab = "Log Health Care Cost [$]", main = "qqPlot of log transformed Health Care Cost",id = F)



###########################################################################
###########################################################################
###                                                                     ###
###                         Exercise 18.c)                              ###
###                                                                     ###
###########################################################################
########################################################################### 

# Estimated mean and sd of the fitted log-transformed costs.
fit_normal_log$estimate
