# Ex 20

d.pet <- read.table("count.txt", header = TRUE)
head(d.pet)
summary(d.pet)

?dpois

la <- mean(d.pet$a.v1)
x <- 0:50
expected <- dpois(x,lambda = la)
plot(x, expected ,type = "h", ylab = "Probability", xlab = "Number of Clicks", main = "Estimated Poisson model")

# b

n <- nrow(d.pet) # Number of observations
set.seed(Sys.time()) # Set seed for the random number generator.
sim <- rpois(n, lambda = la) # Simulating a new series of counts
barplot(table(sim), xlab="Number of Clicks", main="Histogram of simulated data")


# c

hist(d.pet$a.v1,probability = TRUE, main = "Histogram of a.v1", xlab = "Number of Clicks")
lines(x,dpois(x,lambda = la),col = "red", lwd = 2)

library("car")
sim.dist <- rpois(n, lambda= la)
qqPlot(d.pet$a.v1,dist = "pois",lambda = la,main="Q-Q Plot", ylab = "Theoretical Quantiles", xlab = "Observed Quantiles")





