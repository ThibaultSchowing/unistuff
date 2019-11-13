# Exercice 16
B = 1000; 
n = 5; 
la = 2; 
exp.value = 0.5; 
count = 0;
set.seed(5987) 
# Set the random number generator to a starting point. > 
for (i in 1:B){ # Simulate B-times... 
  x = rexp(n,la) 
  # ...n random variables from the exponential distribution... 
  conf.int = c(mean(x) - qnorm(0.95)*sd(x)/sqrt(n), mean(x) + qnorm(0.95)*sd(x)/sqrt(n)) 
  # ...and calculate the confidence interval using the formula: # estimate +/- 1.64*standard-error-of-estimate # (which applies because of the central limit theorem). 
  if(exp.value > conf.int[1] & exp.value < conf.int[2]){
    # Check if the CI contains the true mean. 
    count = count + 1 # If so set the count plus 1. 
  }
} 

prob = count/B # Calculate the probability that in our simulations > # the CI contained the true mean, using > # (# CIs-incl-true-mean)/(total# CIs-created)
prob
