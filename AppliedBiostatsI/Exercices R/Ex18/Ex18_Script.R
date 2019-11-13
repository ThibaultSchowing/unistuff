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

# installed.packages(c("Mass", "car"))

### Required Packages for this Exercise
library("MASS")
library("car")













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



### Use fitdistr function from MASS to do maximum likelihood fitting£: 

fit_normal <- fitdistr(v1, "normal"); fit_normal
fit_exp <- fitdistr(v1, "exponential"); fit_exp

library(fitdistrplus)
fit_normal2 <- fitdist(v1, pnorm, method = "mle"); fit_normal2 ##??
plot(fit_normal2)

### Make a qqPlot of different distribution types


### qqnorm from base packages

# Both identical - qqplot of v1 vs normal distribution
qqnorm(v1)
qqplot(rnorm(1000), v1)


### qqPlot from Car package. This qqPlot function plots the central tendency and a confidence interval



qqPlot(v1, dist = "norm", col.lines = "firebrick2", envelope = 0.95,
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost \n Significantly not normal ? -> shapiro",
       id = F)

### Data doesnt look normally distributed. We can further check using the Shapiro Wilks Method:

shapiro.test(v1)

### The p-value is far below 0.05 implying that our distribution is significantly different from a normal distribution.


### Test other distribution of continuous variable.

qqPlot(v1, dist = "exp",
       col = "grey10", col.lines = "firebrick2", envelope = 0.95,
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost",
       id = F)

### We can see that the exponetial distribution fits the data better than the normal one.


qqPlot(v1, dist = "unif",
       col = "grey10", col.lines = "firebrick2",
       ylab = "Health Care Cost [$]", main = "qqPlot of Health Care Cost",
       id = F)



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
hist(v1.log, breaks = seq(1,7,0.2), col = "light blue", border = "black", ylab = "Density", xlab = "Cost", ylim = c(0, 1) , main = "Monthly costs after a log-transformation \n of the data", freq = F)

# Fit to the normal distribution 
fit_normal_log <- fitdistr(v1.log, "normal"); fit_normal_log


# Displayed as density and not frequency, adding normal curve to see the match
#x <- range(1, 7, 0.001)




# TODO !?!?!?!?
# Plot against the fitted distribution with lines
x <- seq(min(v1.log), max(v1.log), length = 50)

lines(x, dnorm(x, mean = fit_normal_log$estimate["mean"], sd = fit_normal_log$estimate["sd"]), col = "blue")

# Plot against a normal distribuion with log-transformed mean and sd
curve(dnorm(x, mean(v1.log), sqrt(var(v1.log))), lwd=2, col="red", add = T)

# Plot against the fitted distribution with curve
curve(dnorm(x, mean = fit_normal_log$estimate["mean"], sd = fit_normal_log$sd["sd"]), lwd=2, col="black", add = T)


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
