## LINEAR REGRESSION
## =================

## Read in data set: daily energy expenditure vs. fat-free mass
energymass <- read.table("../data/energy.csv", sep = ",", header = TRUE)
## Convert to MJ...
energymass$energy <- 4.1868e-3*energymass$energy
plot(energy ~ mass, data = energymass, pch = energymass$subject, 
  xlab = "Fat-free mass [kg]", ylab = "Energy expenditure [MJ]")


###################################################
## Linear regression
energy.fit <- lm(energy ~ mass, data = energymass)
summary(energy.fit)

# 95% prediction interval for daily energy expenditure
# of person with 65 kg:
beta <- coef(energy.fit)
names(beta) <- NULL
beta0 <- beta[1]
beta1 <- beta[2]
sigma <- summary(energy.fit)$sigma
expend <- beta0 + 65*beta1
pred.interval <- c(expend - qnorm(0.975)*sigma,
                   expend + qnorm(0.975)*sigma)
pred.interval <- c(expend - qnorm(0.975, mean = 0, sd = sigma),
                   expend + qnorm(0.975, mean = 0, sd = sigma))
pred.interval <- c(qnorm(0.025, mean = expend, sd = sigma),
                   qnorm(0.975, mean = expend, sd = sigma))

###################################################
## Residual analysis
## Tukey-Anscombe plot:
plot(fitted(energy.fit), resid(energy.fit), 
  xlab = "Fitted values", ylab = "Residuals")

## Q-Q plot
library(car)
qqPlot(resid(energy.fit), dist = "norm",
  mean = mean(resid(energy.fit)), sd = sd(resid(energy.fit)),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "Q-Q plot of residuals")

## R-squared
cor(energymass$energy, fitted(energy.fit))^2


