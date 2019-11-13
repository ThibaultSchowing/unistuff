# -------------------------------------------------------------------
# R course 2019
# Exercizes day 5
# -------------------------------------------------------------------

# Exercize 5.1 -------------------------------------------------------------------
# 
#  1) Calculate summary statistics for the data set "StudentData2016.txt".
#     Calculate summary statistics for females and males separatly.

ds2016 <- read.table("StudentData2016.txt", header=TRUE, sep="\t",na.string="?")
summary(ds2016)

summary(ds2016[ds2016$Sex=="M",])
summary(ds2016[ds2016$Sex=="W",])


# Exercize 5.2 --------------------------------------------------------------------
# 1) Plot a histogram of student body weight and add a normal distribution with mean and variance 
#    estimated from the observations.

hist(ds2016$Weight,n=25,xlim=c(40,110),freq = F)
hist(ds2016$Weight,n=25,xlim=c(40,110),freq = T)
x=seq(40, 100, length.out = 100)
y=dnorm(x, mean=mean(ds2016$Weight,na.rm=T),sd = sd(ds2016$Weight, na.rm=T))
lines(x, y, col="blue", lwd=2)

#Alternative ways of plotting the normal density
plot(function(x) dnorm(x, mean=mean(ds2016$Weight,na.rm=T),sd = sd(ds2016$Weight, na.rm=T)), 40, 100, add=TRUE,col="red",lwd=2)
curve(dnorm(x, mean=mean(ds2016$Weight,na.rm=T),sd = sd(ds2016$Weight, na.rm=T)), 40, 100, add=TRUE,col="orange",lwd=2)

# 2) Compare the distribution of weight to a normal distribution with a QQ-plot.

qqnorm(ds2016$Weight,pch=16,col="blue")
qqline(ds2016$Weight,lwd=1)

# Exercise 5.3. ----------------------------------------------------------------------
# Here we want to check that the CI contains the true parameter value in 95% of times, 
# if we repeated the sampling procedure 100 times
# Imagine that the height of students follow a Normal distribution with mean 170 and standard deviation 10 (cm)

# 5.3.1. Simulate a random sample of 20 students using function rnorm() and save it into a variable
myRandSample <- rnorm(20, mean=170, sd=10)

# 5.3.2. Compute the 95% CI of the simulated sample using the t.test() function and save it into a variable.
# the output of t.test() function is a list.
# use str() function to check the structure of the variable where you saved the output of t.test().
# you can get the confidence intervals with "var_name$conf.int"
tt <- t.test(myRandSample); tt

# 5.3.3. save the 95% CI into a vector of size 2, using function as.numeric()
ci95 <- as.numeric(tt$conf.int);ci95

# 5.3.4. make a function that does steps 2 to 3, i.e. a function that gets as input a sample and that outputs the 95% CI
get95CI <- function(x) {
  tt <- t.test(x)
  as.numeric(tt$conf.int)
}

# 5.3.5. Perform a for loop, generating 1000 random samples of 20 students from a 
# normal distribution with mean 170 and standard deviation 10.
# For each random sample compute the 95% CI and the mean.
# Save the 95% CI of each sample into a matrix with 2 columns and 1000 rows.
# Save the mean of each sample into a vector with 1000 elements.
# How many times does the 95% CI includes the true value of the mean?
# what is the true mean? what is the distribution of the mean of the samples?
meansample <- numeric(1000)
ci95 <- matrix(NA, nrow=1000, ncol=2)
for(i in 1:1000) {
  x <- rnorm(20, mean=170, sd=10)
  meansample[i] <- mean(x)
  ci95[i,] <- get95CI(x)
}
#The true mean is 170 cm
hist(meansample, freq = F) # the distrution of the mean is also a normal distribution
x=seq(150, 180, 0.01)
lines(x,dnorm(x, mean=170, sd=10/sqrt(20)), col="blue")

sum(ci95[,1] <= 170 & ci95[,2] >= 170) # this should be close to 95% of times where the CI contains the true value of 170 (mean of normal distribution)
# this is expected given a confidence interval of 95%


# Exercize 5.4 --------------------------------------------------------------------
# 
# 5.4.1 Calculate the 95% CIs for the heights of the StudentData2016.txt females and males separatly. 
# What does the result suggest?

ind.M <- which(ds2016$Sex=="M"); ind.M
ind.F <- which(ds2016$Sex=="W"); ind.F
height.m <- ds2016$Height[ind.M]
height.f <- ds2016$Height[ind.F]

t.test(height.m)$conf.int
t.test(height.f)$conf.int

# The CIs are non-overlapping, suggesting that the means are significantly different from each other

# 5.4.2 Directly test that the heights of males and females are different by means of a t-test
t.test(height.m, height.f)


# Exercize 5.5 -------------------------------------------------------------------------
#
# Create a contingency table showing the frequency distribution of the variables 
# "Sex" and "Smoking". Use the chi square test to test if the two variables are independent.
# Hint 1: If you pass a contingency table to the function "chisq.test, Pearson's chi-squared test is 
# performed with the null hypothesis that the joint distribution of the cell counts in a 2-dimensional 
# contingency table is the product of the row and column marginals.
# Hint 2: Two random variables X and Y are independent if P (X = x and Y = y) = P(X = x) P(Y = y).

tab <-table(ds2016$Sex,ds2016$Smoking); tab
chisq.test(tab)

# p-values is 0.0452 < 0.05. Therefore we can reject the null-hypothesis that the two random variables 
# are independent. There is an apparent difference in smoking behavior between males and females
#There is a higher proporton of occasional male smokers in the 2016 studnt cohort

# Exercize 5.6 --------------------------------------------------------------------
#
# 5.6.1 Make a QQ-plot to compare the distributions of weights and heights in 2016. What does the plot tell you?

qqp=qqplot(ds2016$Weight,ds2016$Height)
plot(qqp,pch=16,col="darkgray", ylab="height", xlab="weight")

# 5.6.2 Now plot the line that goes through the qqplot points. What does it tell you? 
#       Note: This cannot be done using qqline, which only applies to qqnorm.
relm=lm(qqp$y~qqp$x)
abline(relm, lwd=2, col="blue")
str(qqp)

# The points fall on a line, suggesting that there is a linear relationship between the variables. 

# 5.6.3 Further check the relationship between the two vaiables by plotting 
# the data against each other and overlay a regression line obtained using the lm function

plot(ds2016$Weight, ds2016$Height,pch=16,col=rgb(0.2,0.2,1,0.4),cex=1.5,xlab="weight",ylab="height") #col=rgb(0.2,0.2,1,0.4) makes transparent colors
reg=lm(ds2016$Height~ds2016$Weight)
abline(reg, lwd=2, col="blue")
summary(reg)

#Exercise 5.7 --------------------------------------------------------
#
# Follow the smoking habits in years 2003, 2014 and 2016. What do you see?

ds2003 <- read.table("StatWiSo2003.txt", header=TRUE, sep="\t",na.string="?")
ds2014 <- read.table("StudentData2014.txt", header=TRUE, sep="\t",na.string="?")
str(ds2003)
str(ds2014)

smoke2003=table(ds2003$Rauchen)/length(ds2003$Rauchen);
smoke2014=table(ds2014$Rauchen)/length(ds2014$Rauchen);
smoke2016=table(ds2016$Smoking)/length(ds2016$Smoking);
plot(smoke2003, type="b", col="blue", ylim=c(0,0.8));
lines(smoke2014, type="b", col="orange")
lines(smoke2016, type="b", col="black")

#There is an increase in non-smokers between 2003 and 2014, 
#and a constant drop in regular smokers from 2003 to 2016
