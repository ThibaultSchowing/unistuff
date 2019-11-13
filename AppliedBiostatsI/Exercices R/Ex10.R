#Exercise 10
# Normal distribution with mean = 32 and sd = 6

x <- seq(5, 60, length=1000)
y <- dnorm(x, mean=32, sd=6)
plot(x, y, type="l", lwd=1, xlab = "Lead content", ylab = "Probability")

# Area between 26 and 38
x2=seq(26,38,length=100)
y2=dnorm(x2,mean=32,sd=6)
polygon(c(26,x2,38),c(0,y2,0),col="red")

legend(x = 3, y=0.069,legend=c("P[ 26 < x < 38]"), col=c("red"), lty=1:5, cex=0.8)

# F) probability between 26 and 38
pnorm(38, mean = 32, sd = 6) - pnorm(26, mean = 32, sd = 6)

# B) What is the probability that a sample of soil contains at most 40 ppb of lead?

pnorm(40, 32, 6)

# C) Calculate the probability that a sample of soil contains at most 27 ppb of lead?

pnorm(27,32,6)

# D) Below which concentration falls the lead content with probability 97:5%? That is, determine c such that P[X <= c] = 97:5%.

qnorm(0.975, 32,6)


# E) Below which concentration falls the lead content with probability 10%?

qnorm(0.1, 32, 6)









