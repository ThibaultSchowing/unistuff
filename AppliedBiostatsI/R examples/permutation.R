## PERMUTATION TEST
##
## AIM: test hypothesis "men are on average taller than
## women"
subjects <- data.frame(
  name = c("Nora", "Christoph", "Livio", "Nico", "Yasemin", "Nathalie", "Sakshi"),
  height = c(168, 178, 172, 179, 172, 168, 166),
  sex = as.factor(c("f", "m", "m", "m", "f", "f", "f")))

## Test statistic
D <- mean(subjects$height[subjects$sex == "m"])- 
  mean(subjects$height[subjects$sex == "f"])

## Random assignment of sexes to approximate distribution
## of test statistic under null hypothesis that sex does not
## influence the mean height

#####################################################################
## MANUAL PERMUTATION / RANDOM ASSIGNMENTS
sex.rand <- list()
D.rand <- numeric(5)

## 1. random assignment
sex.rand[[1]] <- as.factor(c("m", "f", "f", "f", "m", "m", "f"))
D.rand[1] <- mean(subjects$height[sex.rand[[1]] == "m"]) - 
  mean(subjects$height[sex.rand[[1]] == "f"])

## 2. random assignment
sex.rand[[2]] <- as.factor(c("f", "m", "m", "f", "f", "m", "f"))
D.rand[2] <- mean(subjects$height[sex.rand[[2]] == "m"]) - 
  mean(subjects$height[sex.rand[[2]] == "f"])

## 3. random assignment
sex.rand[[3]] <- as.factor(c("m", "m",  "f", "m", "f", "f", "f"))
D.rand[3] <- mean(subjects$height[sex.rand[[3]] == "m"]) - 
  mean(subjects$height[sex.rand[[3]] == "f"])

## 4. random assignment
sex.rand[[4]] <- as.factor(c("f", "f", "m", "f", "f", "m", "m"))
D.rand[4] <- mean(subjects$height[sex.rand[[4]] == "m"]) - 
  mean(subjects$height[sex.rand[[4]] == "f"])

## 5. random assignment
sex.rand[[5]] <- as.factor(c("f", "f", "m", "m", "f", "f", "m"))
D.rand[5] <- mean(subjects$height[sex.rand[[5]] == "m"]) - 
  mean(subjects$height[sex.rand[[5]] == "f"])

## Histogram of randomized D-values
hist(D.rand, xlim = range(c(D.rand, D)), freq = FALSE)
abline(v = D, col = "red")

#####################################################################
## AUTOMATIC PERMUTATION / RANDOM ASSIGNMENT
## set seed for reproducibility
set.seed(42)

## Randomly assign sexes to subjects
N <- 50
n.sub <- nrow(subjects)
n.male <- sum(subjects$sex == "m")
males.rand <- replicate(N, sample.int(n.sub, n.male))

## Calculate sample distribution of height differences
D.sample <- numeric(N)
for (i in 1:N)
  D.sample[i] <- mean(subjects$height[males.rand[, i]]) -
    mean(subjects$height[-males.rand[, i]])

## For experienced R users: better code
mean.diff <- function(i)
{
  mean(subjects$height[males.rand[, i]]) -
    mean(subjects$height[-males.rand[, i]])
}
D.sample <- sapply(1:N, mean.diff)

## Histogram of randomized D-values
hist(D.sample, freq = FALSE)
abline(v = D, col = "red")

## Threshold for range of rejection
abline(v = quantile(D.sample, 0.95))

## p-value of randomization test
sum(D.sample >= D)/N

