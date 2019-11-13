### DESCRIPTIVE STATISTICS
### @author Alain Hauser <alain.hauser@bfh.ch>
### @date 2014-10-13

###################################################
## Read in data set
mao.dat <- read.table("../data/mao.dat", header = TRUE, sep = "\t")
x <- mao.dat$activity[mao.dat$type == 1]

###################################################
## Mean, median, quantiles, etc.
mean(x)
median(x)
quantile(x, p = 0.5)

length(x)
x.sort <- sort(x)
x.sort[9]
x.sort[10]

x.sort[1]
x.sort[2]
quantile(x, p = 1/18)

###################################################
## Histogram, density, and ECDF
par(mfrow = c(2, 2), cex = 0.5)
for (k in c(5, 9, 15, 25)) {
  mao.hist <- hist(x, breaks = k, freq = FALSE, xlab = "MAO activity", main = "")
  title(sprintf("%d bins", length(mao.hist$breaks) - 1))
}

# Density plot
par(mfrow = c(1, 1))
dens <- density(x)
plot(dens$x, dens$y, type = "l")
# Vary bandwidth
dens <- density(x, bw = 1)
plot(dens$x, dens$y, type = "l")

# Box plot
boxplot(x)

# ECDF
plot(ecdf(x))

