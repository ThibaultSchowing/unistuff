#############################333
#
# Ex 17
#
################################

### Required Packages for this Exercise
library("MASS")
library("car")
library("fitdistrplus")
alpha <- 0.05


fracture <- read.table("bone-fracture.csv", sep = ";", header = TRUE)
conc <- fracture$conc
dif <- fracture$dif
no.cells <- fracture$no.cells
hit <- fracture$hit

#############
# Conc
#############

hist(conc, breaks=20)
# looks approx normal
fit.conc <- fitdistr(conc, "normal");fit.conc

# Numbers in brackets are the standart errors of the estimates

conc.lower <- fit.conc$estimate - qnorm(1 - alpha/2)*fit.conc$sd;conc.lower
conc.upper <- fit.conc$estimate + qnorm(1 - alpha/2)*fit.conc$sd;conc.upper
print("Here above, sd is the estimated standart error, not the standart deviation")

par(mfrow = c(1, 2))

qqPlot(conc, dist = "norm", mean = fit.conc$estimate["mean"], sd = fit.conc$estimate["sd"], xlab= "Theoretical quantiles (norm)", ylab = "Empirical quantiles") 
hist(conc, breaks = 20, freq = FALSE, main = "")

x.val <- seq(min(conc), max(conc), length = 50)

lines(x.val, dnorm(x.val, mean = fit.conc$estimate["mean"], sd = fit.conc$estimate["sd"]))




plot.density <- function(x, estimate, dist, ...) {
  
  
}  
par(mfrow = c(1, 2)) do.call(qqPlot, c(list(x = x, dist = dist), as.list(estimate), xlab = sprintf("Theor. quantiles (ylab = \"Empirical quantiles")) hist(x, freq = FALSE, main = "", ...) 
                                                                              
if (is.integer(x)) x.val <- seq(min(x), max(x)) else x.val <- seq(min(x), max(x), length.out = 50) lines(x.val, do.call(sprintf("dc(list(x = x.val), as.list(estimate))))
















