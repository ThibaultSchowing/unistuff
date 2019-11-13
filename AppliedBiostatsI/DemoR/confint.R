### STANDARD ERROR OF THE MEAN AND CONFIDENCE INTERVALS
### @author Alain Hauser <alain.hauser@bfh.ch>
### @date 2014-10-20

###################################################
## SEM and SD of distribution
babyboom <- read.table("../data/babyboom.dat", header = TRUE)
wt.mean <- mean(babyboom$weight)
wt.sd <- sd(babyboom$weight)
wt.se <- wt.sd/sqrt(nrow(babyboom))

###################################################
## Confidence interval for mean
wt.confint <- c(wt.mean - qnorm(0.975)*wt.se, wt.mean + qnorm(0.975)*wt.se)

