# Ex21
neckshoulder <- read.table("neckshoulder.txt", header = TRUE)

summary(neckshoulder)

before <- neckshoulder$before
after <- neckshoulder$after
dif = before - after

library(car)
qqPlot(dif, dist = "norm", mean = mean(dif), sd = sd(dif), xlab = "Theor. quantiles (norm)", ylab = "Empirical quantiles", main = "Differences")

t.test(after, before, alternative = "two.sided", paired = TRUE, conf.level = 0.9)

# manual t.test
t.stat <- sqrt(length(dif))*mean(dif)/sd(dif);t.stat


#For a paired test on a significance level of 10%, the region of rejection lies below the 5% quantile and above the 95% quantile of the null distribution of the test statistic. In our case, the null hypothesis is rejected if jTj > tn􀀀1;0:95; this is indeed the case:

qt(0.95, length(dif) - 1)
abs(t.stat) > qt(0.95, length(dif) - 1)



