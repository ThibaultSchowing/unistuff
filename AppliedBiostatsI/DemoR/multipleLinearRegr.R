## MULTIPLE LINEAR REGRESSION

###################################################
## Child mortality data set
library(car)
data(Leinhardt)
plot(infant ~ income, data = Leinhardt, pch = 20, main = "Infant Mortality",
  xlab = "Income [US$]", ylab =  "Infant mortality")

# Marginal histograms
par(mfrow = c(1, 2))
hist(Leinhardt$income, freq = FALSE, xlab = "Income [US$]", main = "")
hist(Leinhardt$infant, freq = FALSE, xlab = "Infant mortality", main = "")

# Linear regression after log-transformation
# and removal of outliers
par(mfrow = c(1, 1))
plot(log(infant) ~ log(income), data = Leinhardt, 
  pch = 20, main = "Infant Mortality")
points(log(Leinhardt$income)[c(26, 28)], log(Leinhardt$infant)[c(26, 28)], 
  cex = 3, col = "red")
im.fit <- lm(log(infant) ~ log(income), 
  data = Leinhardt[-c(26, 28), ])
abline(im.fit, col = "red")

# Tukey-Anscombe and Q-Q plot
par(mfrow = c(1, 2))
plot(fitted(im.fit), resid(im.fit), 
  xlab = "Fitted values", ylab = "Residuals", main = "Tukey-Anscombe plot")
library(car)
qqPlot(resid(im.fit), dist = "norm",
  mean = mean(resid(im.fit)), sd = sd(resid(im.fit)),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "Q-Q plot of residuals")

# Prediction: back-transformation of fitted model
par(mfrow = c(1, 1))
plot(infant ~ income, data = Leinhardt,
  pch = 20, col = gray(0.6))
pred <- exp(predict(im.fit, newdata = 
  data.frame(income = Leinhardt$income)))
ord <- order(Leinhardt$income)
lines(Leinhardt$income[ord], pred[ord])


###################################################
## Air pollution data set
ap <- read.table("airpollution.csv", header = TRUE, sep = ",")
ap$City <- NULL

# Marginal histograms
par(mfrow = c(4, 4), mar = c(2, 2, 2, 1))
for (i in 1:ncol(ap)) {
  hist(ap[, i], freq = FALSE, main = colnames(ap)[i],
  xlab = "", ylab = "")
}

# Regression with 2 explanatory variables
library(car)
scatter3d(Mortality ~ JanTemp + NonWhite, data = ap)
    
# Multiple linear regression
ap.fit <- lm(Mortality ~ JanTemp + 
  JulyTemp + RelHum + Rain + Educ + 
  Dens + NonWhite + WhiteCollar + 
  log(Pop) + House + Income + 
  log(HC) + log(NOx) + log(SO2), 
  data = ap)
summary(ap.fit)

# Residual analysis
par(mfrow = c(1, 2))
plot(fitted(ap.fit), resid(ap.fit), 
  xlab = "Fitted values", ylab = "Residuals", main = "Tukey-Anscombe plot")
qqPlot(resid(ap.fit), dist = "norm",
  mean = mean(resid(ap.fit)), sd = sd(resid(ap.fit)),
  xlab = "Theoretical quantiles", ylab = "Empirical quantiles",
  main = "Q-Q plot of residuals")


# Comparing coefficients: multiple vs. simple regression
lm(Mortality ~ JanTemp, data = ap)
lm(Mortality ~ JulyTemp, data = ap)
lm(Mortality ~ ., data = ap)

# Likelihood ratio test
ap.fit.red <- lm(Mortality ~ JanTemp + JulyTemp + Rain + 
  Educ + Dens + NonWhite + WhiteCollar + log(Pop) + 
  House + Income + log(HC) + log(NOx) + log(SO2), 
  data = ap)
library(lmtest)
lrtest(ap.fit.red, ap.fit)

ap.fit.red2 <- lm(Mortality ~ JanTemp + JulyTemp + Rain + 
  Educ + Dens + NonWhite + WhiteCollar + log(Pop) + 
  log(HC) + log(NOx) + log(SO2), 
  data = ap)
library(lmtest)
lrtest(ap.fit.red2, ap.fit)

# Backward selection
ap.full <- lm(Mortality ~ JanTemp + JulyTemp + RelHum + 
  Rain + Educ + Dens + NonWhite + WhiteCollar + 
  log(Pop) + House + Income + log(HC) + log(NOx) +
  log(SO2), data = ap)
ap.bw <- step(ap.full, direction = "backward", trace = 0)
summary(ap.bw)

# Forward selection
ap.empty <- lm(Mortality ~ 1, data = ap)
ap.fw <- step(ap.empty, direction = "forward", trace = 0)
summary(ap.fw)

# Further fine tuning
ap.tune <- update(ap.bw, . ~ . - WhiteCollar)
lrtest(ap.tune, ap.bw)
par(mfrow = c(1, 1))
plot(fitted(ap.tune), resid(ap.tune))

