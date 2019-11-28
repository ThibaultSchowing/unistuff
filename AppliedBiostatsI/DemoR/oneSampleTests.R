### ONE-SAMPLE TESTS
### @author Alain Hauser <alain.hauser@bfh.ch>
### @date 2015-11-23

###################################################
## Read in data set, load libraries
library(car)
bloodflow <- read.table("bloodFlow.csv", header = TRUE, sep = ",")
n <- nrow(bloodflow)
X <- bloodflow$Caffeine - bloodflow$Baseline

###################################################
## Q-Q plot
qqPlot(X, dist = "norm", mean = mean(X), sd = sd(X),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles", main = "Q-Q plot")


###################################################
## t-tests

# Two-sided
t.test(bloodflow$Caffeine, bloodflow$Baseline, paired = TRUE,
  alternative = "two.sided", conf.level = 0.95)
# One-sided
t.test(bloodflow$Caffeine, bloodflow$Baseline, paired = TRUE,
  alternative = "less", conf.level = 0.95)

###################################################
## Sign test
V <- sum(bloodflow$Caffeine > bloodflow$Baseline)
binom.test(V, n, p = 0.5, alternative = "two.sided", conf.level = 0.95)


###################################################
## Wilcoxon signed-rank test

# Two-sided
wilcox.test(bloodflow$Caffeine, bloodflow$Baseline, paired = TRUE,
  exact = TRUE, alternative = "two.sided", conf.level = 0.95)
# One-sided
wilcox.test(bloodflow$Caffeine, bloodflow$Baseline, paired = TRUE,
  exact = TRUE, alternative = "less", conf.level = 0.95)

###################################################
## Manuel t-test

# Situation: a producer of pet food sells food in bags of 500 g.
# He fears his filling machine is not calibrated. To test this,
# he takes a random sample of 12 food bags and measures the
# content. He finds the following weights:

weights <- c(514, 510, 497, 508, 496, 517, 503, 504, 498, 515, 506, 510)

# Perform a t-test; what is the test decision?

T <- sqrt(12)*(mean(weights) - 500)/sd(weights)

# Quantiles of t distribution:
qt(0.025, df = 11)
qt(0.05, df = 11)

# p-values:
# mu != mu0
2*(1 - pt(3.16, df = 11))

# mu < mu0
pt(3.16, df = 11)

# mu > mu0
1 - pt(3.16, df = 11)

