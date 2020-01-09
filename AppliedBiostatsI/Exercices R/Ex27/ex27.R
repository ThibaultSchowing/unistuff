#ex27
library(permute)
data(jackal)
jackal

# Just to know
jack.t <-t.test(Length ~ Sex, data = jackal, var.equal = TRUE, alternative = "greater");jack.t

jackals.df <- as.data.frame(jackal);jackal.df

jackals.m <- jackals.df[jackal.df$Sex == "Male",1]; jackals.m
jackals.f <- jackals.df[jackal.df$Sex == "Female",1];jackals.f


n <- length(jackals.m);n
m <- length(jackals.f);m


#grp1 = vector of indexes between 1 and 20 
# real values: 

all.values <- c(c(jackals.m),c(jackals.f))

meandiff <- function(grp1){
  
  mean.diff <- mean(all.values[grp1]) - mean(all.values[-grp1])
  return(mean.diff)
}


set.seed(12)

N <- 999
D <- meandiff(1:n)
D.sample <- replicate(N, meandiff(sample.int(n+m, size = n)))

quantile(D.sample, c(0.025, 0.975))

# p-value: fraction of random sample diff that are bigger than the actual diff
# divided by the totalnumber of experiments

sum(abs(D.sample) >= abs(D))/N

library(perm)
permTS(jackals.m, jackals.f, alternative="greater", method = "exact.mc")


# t-test prefered because data should be normally distributed
