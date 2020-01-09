# Ex25

astro <- read.table("astro.dat", header = T);astro
dif <- astro$after - astro$before

library(car)
qqPlot(dif, dist = "norm", mean = mean(dif), sd = sd(dif))


# We have to use a paired test as data are... paired

t.test(astro$after, astro$before, paired = T, alternative = "two.sided")

t.test(astro$after[astro$salt == 1], astro$after[astro$salt == 0], paired = F, alternative = "two.sided")



