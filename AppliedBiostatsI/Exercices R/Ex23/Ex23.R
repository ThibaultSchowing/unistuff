# Exercise 23
library(car)

training <- read.table("training.txt", header = T)
training <- as.data.frame(training);training

# We can already see one outlier in the table

par(mfrow = c(1,3), cex = 0.6)

before <- training$before
after <- training$after
dif <- after - before;dif
qqPlot(before, dist = "norm", sd = sd(before), mean = mean(before), xlab = "Theor. quantiles (norm)", ylab = "Empirical quantiles", main = "before")

qqPlot(after, dist = "norm", sd = sd(after), mean = mean(after), xlab = "Theor. quantiles (norm)", ylab = "Empirical quantiles", main = "after")

qqPlot(dif, dist = "norm", sd = sd(dif), mean = mean(dif), xlab = "Theor. quantiles (norm)", ylab = "Empirical quantiles", main = "dif")

# except the outlier, the data can be assumed as normally distributed

# A bit more exploration: 

plot(training)
plot(training$before)
plot(training$after)


# Perform a test to see in the muscle activation can be increased with the training program 
n <- 10
pi <- 0.5
pbinom(5:10,n,pi,lower.tail=FALSE) # = 1 - pbinom(5:10, n, pi)
