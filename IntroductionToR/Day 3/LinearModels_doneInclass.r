# Check the working directory
getwd()

# load the dataset iris
data(iris)
# check the structure of the variable iris
str(iris)

# plot relationship between response variable "Petal length"
# and independent variable "petal width"
plot(x=iris$Petal.Width, y=iris$Petal.Length, 
     xlab="Petal Width", ylab="Petal length",
     ylim=c(-1,8))

# perform the linear regression with function lm()
iris.lm <- lm(Petal.Length ~ Petal.Width, data=iris)
abline(iris.lm$coefficients, col="red", lwd=5)
# null model - no relationship (slope=0, intercept=0)
abline(0,0, lty=3, col="blue", lwd=2)
# null model - no relationship (slope=0)
abline(iris.lm$coefficients[1],0, lty=2, col="cyan", lwd=2)
# look at summary to check the p-values and R-square
summary(iris.lm)

# ANOVA
boxplot(iris$Petal.Length ~ iris$Species, ylab="Petal length")
iris.anova <- lm(iris$Petal.Length ~ iris$Species)

summary(iris.anova)
abline(h=1.46200, col="blue", lty=3)
abline(h=1.46200+2.79800, col="red", lty=3)
abline(h=1.46200+4.09000, col="green", lty=3)

