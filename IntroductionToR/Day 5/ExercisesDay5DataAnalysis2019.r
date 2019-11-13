# -------------------------------------------------------------------
# R course 2019
# Exercizes day 5
# -------------------------------------------------------------------

# Exercize 5.1 -------------------------------------------------------------------
# 
#  1) Calculate summary statistics for the data set "StudentData2016.txt".
#     Calculate summary statistics for females and males separatly.

df = read.table("StudentData2016.txt", header = T, na.strings = "?")

summary(df)
summary(df[df$Sex=="M",])
summary(df[df$Sex=="W",])

#df$Weight <- as.numeric(as.character(df$Weight))
#summary(df)
#summary(df[which(df$Sex=='W'),])
#summary(df[which(df$Sex=='M'),])
     
# Exercize 5.2 --------------------------------------------------------------------
# 1) Plot a histogram of student body weight and add a normal distribution with mean and variance 
#    estimated from the observation

# remove NA
dfna <- na.omit(df)
# plot
hist(dfna$Weight, breaks = seq(min(dfna$Weight), max(dfna$Weight), 1), xlab = "Weight", main = "Weight distribution")

# solution of Escofier with density distribution instead of frequency
# we need the density if we superimpose the density distribution over the graph
hist(df$Weight, n=25, xlim = c(40,110), freq = F)
x=seq(40, 100, length.out = 100)
y=dnorm(x, mean=mean(df$Weight, na.rm=T), sd = sd(df$Weight, na.rm = T))
lines(x, y, col="blue", lwd=2)

# Alternative way of ploting
#plot(function(x) dnorm(x, mean=mean(df$Weight, na.rm=T), sd = sd(df$Weight, na.rm = T)))


weights <- df$Weight
heights <- df$Height

# 2) Compare the distribution of weight to a normal distribution with a QQ-plot.
qqnorm(weights, main="QQPlot of students weight")
qqline(weights)




# others / ignore
qqnorm(heights, main="QQPlot of students heights")
qqline(heights)

hist(heights, freq = F)
xseq = seq(150, 200, 1)
lines(xseq, dnorm(xseq, mean=mean(heights), sd=sd(heights)))
abline(v=mean(heights), col = "blue", lwd = 3)

# Exercise 5.3. ----------------------------------------------------------------------
# Here we want to check that the CI contains the true parameter value in 95% of times, 
# if we repeated the sampling procedure 100 times
# Imagine that the height of students follow a Normal distribution with mean 170 and standard deviation 10 (cm)
# 5.3.1. Simulate a random sample of 20 students using function rnorm() and save it into a variable

spldst <- rnorm(20, mean = 170, sd = 70)


# 5.3.2. Compute the 95% CI of the simulated sample using the t.test() function and save it into a variable.

ttest <- t.test(spldst, df$Height, paired = FALSE)


# the output of t.test() function is a list.
# use str() function to check the structure of the variable where you saved the output of t.test().
str(ttest)

# you can get the confidence intervals with "var_name$conf.int"
# 5.3.3. save the 95% CI into a vector of size 2, using function as.numeric()

CI <- c(as.numeric(ttest$conf.int[1]), as.numeric(ttest$conf.int[2]))
# 5.3.4. make a function that does steps 2 to 3, i.e. a function that gets as input a sample and 
# that outputs the 95% CI

# also it generates a normal distribution
asdf <- function(smpl){
  spldst <- rnorm(20, mean = 170, sd = 70)
  ttest <- t.test(spldst, smpl, paired = FALSE)
  print(c(as.numeric(ttest$conf.int[1]), as.numeric(ttest$conf.int[2])))
}

asdf(df$Height)

# 5.3.5. Perform a for loop, generating 1000 random samples of 20 students from a 
# normal distribution with mean 170 and standard deviation 10.
# For each random sample compute the 95% CI and the mean.
# Save the 95% CI of each sample into a matrix with 2 columns and 1000 rows.
# Save the mean of each sample into a vector with 1000 elements.
# How many times does the 95% CI includes the true value of the mean?
# what is the true mean? what is the distribution of the mean of the samples?

cim <- matrix(nrow = 1000, ncol = 2)
mc <- c()

# True data mean
dfmean <- mean(df$Height)
meanInCI <- 0

for(i in 0:1000){
  # Generate 20 random students weight 
  students <- rnorm(20, mean = 170, sd = 10)
  mean <- mean(students)
  
  ttest <- t.test(students)
  #print(ttest)
  low <- as.numeric(ttest$conf.int[1]) 
  cim[i,1] <- low
  hi <- as.numeric(ttest$conf.int[2]) 
  cim[i,2] <- hi
  
  mc <- c(mc, mean)
  
  #cat("Low: ", low, "\tHi: ", hi, "\tMean", mean, "\n")
  
  # count if the mean is in the CI
  if(dfmean > low & dfmean < hi){
    meanInCI = meanInCI + 1
  }
  
}

#Number of time true mean is in CI
print(meanInCI)

hist(mc, freq = F, main = "Random sample of Students Heights")

plot(density(mc))

x=seq(150, 180, length.out = 100)

######COOOOOL
# On doit diviser par la sqrt(20) car la distribution variance densité moyenne etc trop chaud
y=dnorm(x, mean=mean(df$Height, na.rm=T), sd = sd(df$Height, na.rm = T)/sqrt(20))
lines(x, y, col="blue", lwd=2)

ysim = dnorm(x, mean=170, sd=10/sqrt(20))
lines(x, ysim, col="red", lwd=2)


# Exercize 5.4 --------------------------------------------------------------------
# 
# 5.4.1 Calculate the 95% CIs for the heights of the StudentData2016.txt females and males separatly. 
# What does the result suggest?
# 5.4.2 Directly test that the heights of males and females are different by means of a t-test

df2 <- read.table("StudentData2016.txt", header = TRUE, na.strings = "?")

ttmale <- t.test(df2$Height[df2$Sex=="M"])
ttfemale <- t.test(df2$Height[df2$Sex=="W"])

print(ttmale$conf.int)
print(ttfemale$conf.int)

# To formally test
t.test(df2$Height[df2$Sex=="M"],df2$Height[df2$Sex=="W"])

# Ho dingue: mens are taller

# Exercize 5.5 -------------------------------------------------------------------------
#
# Create a contingency table showing the frequency distiribution of the variables 
# "Sex" and "Smoking". Use the chi square test to test if the two variables are independent.
# Hint 1: If you pass a contingency table to the function "chisq.test, Pearson's chi-squared test is 
# performed with the null hypothesis that the joint distribution of the cell counts in a 2-dimensional 
my.table <- table(df2$Sex, df2$Smoking);my.table
prop.table(my.table)

chisq.test(my.table)

# contingency table is the product of the row and column marginals.
# Hint 2: Two random variables X and Y are independent if P (X = x and Y = y) = P(X = x) P(Y = y).

#p-value is < 0.05 -> smaller than 0.05 -> smoking habits are different.
# Warnings: some of the expected entries are smaller than 5 -> small sample

# Exercize 5.6 --------------------------------------------------------------------
#
# 5.6.1 Make a QQ-plot to compare the distributions of weights and heights in 2016. What does the plot tell you?

weights <- df2$Weight
heights <- df2$Height


qqp=qqplot(weights, heights)
relm=lm(qqp$y~qqp$x)
abline(relm, lwd=2, col="blue")

plot(weights, heights, main="Height vs Weight")
my.lm <- lm(heights~weights)
abline(my.lm$coefficients[1], my.lm$coefficients[2])





#NOT WHAT IS ASKED
qqnorm(weights, main="QQPlot of students weight")
qqline(weights)

qqnorm(heights, main="QQPlot of students height")
qqline(heights)


# 5.6.2 Now plot the line that goes through the qqplot points. What does it tell you? 
#       Note: This cannot be done using qqline, which only applies to qqnorm.
# 5.6.3 Further check the relationship between the two vaiables by plotting 
# the data against each other and overlay a regression line obtained using the lm function



#Exercise 5.7 --------------------------------------------------------
#
# Follow the smoking habits in years 2003, 2014 and 2016. What do you see?

df2003 <- read.table("StatWiSo2003.txt", header = T, na.strings = "?")
df2014 <- read.csv("StudentData2014.txt", header = T, na.strings = "-")
df2016 <- read.csv("StudentData2016.txt", header = T, na.strings = "?")

smoke2003 <- table(df2003$Rauchen)/length(df2003$Rauchen)






