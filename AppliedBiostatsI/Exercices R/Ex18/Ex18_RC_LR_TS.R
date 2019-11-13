# Applied biostatistics I - Exercise 18
# Rares Cristea, Lionel Rohner, Thibault Schowing
#
# 14.11.19


# Scan file
scan("health-care-cost.txt")


# Load MASS library
library(MASS)

cost <- read.csv("health-care-cost.txt", header = F)
str(cost)
hist(cost$V1, breaks = 80, col = "light blue", border = "black", ylab = "Density", xlab = "Cost", main = "Monthly costs")

f1 <- fitdistr(cost$V1, "Poisson")


f2 <- fitdistr(cost$V1, "normal")
f2


f3 <- fitdistr(cost$V1, "exponential")

x = 0:600; lambda_ = f1$estimate[1]; lambda
curve(dnorm(x, 102, sqrt(102)), lwd=2, col="red", add = T)

# dnorm(x, lambda_, sqrt(lambda_))

# Two identical ways
qqplot(cost$V1, dpois(x, lambda_))
qqplot(cost$V1, dnorm(x, lambda_, sqrt(lambda_)))


qqnorm(cost$V1)
qqline(cost$V1, col = "red")

qqnorm(dnorm(x, 102, sqrt(102)))
qqline(dnorm(x, 102, sqrt(102)), col = "red")

# https://rcompanion.org/handbook/I_12.html
# https://math.stackexchange.com/questions/2412983/plotting-in-r-probability-mass-function-for-a-poisson-distribution


# Log transform the data
cost$logV1 <- log(cost$V1)

# Plot the log transformed data
hist(cost$logV1, breaks = 80, col = "light blue", border = "black", ylab = "Density", xlab = "Cost", main = "Monthly costs")

