
# 12 or less successes, with a sample of size 28 with a 50% success rate ?
pbinom(12,size = 28, prob = 0.5)
#> [1] 0.2857

plot(dbinom(0:28, size=28,prob=0.63))
lines(dbinom(0:28, size=28, prob=0.2))
abline(v=12, col="red", lwd=2)

lines(dbinom(0:28, size=28,prob=0.3),col="blue")

# Power of true hypothesis with different parameters
pbinom(12,size=28,prob=0.3)
#> [1] 0.9508962
pbinom(12,size=28,prob=0.2)
#> [1] 0.9985477
pbinom(12,size=28,prob=0.1)
#> [1] 0.9999991




x = rnorm(100,0,1)
hist(x)
t.test(x) # null hypothesis, mean = 0 (read output)
x = rnorm(100,1,1)
hist(x)
t.test(x) # null hypothesis, mean = 0 (read output)

?t.test




