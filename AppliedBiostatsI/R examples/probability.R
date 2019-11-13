### PROBABILITY DISTRIBUTIONS
###########################################################

## Binomial distribution
?dbinom
plot(0:15, dbinom(0:15, size = 15, prob = 0.2),
     type = "h", xlab = "x", ylab = "p(x)")

## Drug test example
prob <- 1/1000
1 - pbinom(2, size = 200, prob = prob)

# 1 - CDF(2) -> 1 - prob(X <= 2) = Prob (X > 2) = Prob(X) >= 3)

?pbinom
