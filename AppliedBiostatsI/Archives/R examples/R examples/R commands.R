library(car) 
baby  = read.table("/Users/Stephan/Dropbox/Teaching/HS 2017/Applied BioStat I 2017 HS/Topics/data/babyboom.dat",header=T)
str(baby)
dim(baby)
x = baby$weight
x

hist(x,axes=F,breaks=15)
axis(1)
axis(2)
(est.mean <- mean(x))
(est.sd <- sd(x))
qqPlot(x, dist = "norm", mean = est.mean, sd = est.sd)

theoretical.quant = qnorm(mean=est.mean,sd=est.sd,seq(0,1,by=0.05))
empirical.quant = quantile(x,seq(0,1,by=0.05))
plot(theoretical.quant,empirical.quant)
abline(0,1)
qqnorm(x)

x =  baby$minute[-1] -baby$minute[-44] 
hist(x,breaks=15)
(rate <- 1/mean(x))
qqPlot(x, dist = "exp", rate = rate)


pbinom(10:15,p=0.631,size=28)
plot(10:15,pbinom(10:15,p=0.631,size=28),ylab="P(X <= k)",xlab="k")
abline(h=0.05,lwd=2,lty=2)


plot(0:28,pbinom(0:28,p=0.631,size=28),ylab="P(X <= k)",xlab="k")
abline(h=0.05,lwd=2,lty=2)

plot((dbinom(0:28,0.631,size=28)),pch=16)
abline(v = 13,col="red")



#-----
library(readr)

bloodflowCaffeine <- read_csv("~/Dropbox/Teaching/HS 2017/Applied BioStat I 2017 HS/Topics/data/bloodFlow.csv")
str(bloodflowCaffeine)
matplot(t(bloodflowCaffeine[,-1]),pch=16,type="b",col=1,lty=1,ylab="MBF",axes=F)
axis(1,at=c(1,2),labels=c("Baseline","Caffeinated"))
axis(2)

t.test(bloodflowCaffeine$Caffeine, bloodflowCaffeine$Baseline, paired = TRUE, alternative = "two.sided", conf.level = 0.95)

#---
# Plot t-distribution with 7 degrees of freedom
x = seq(-10,10,by=0.1)
plot(x,dt(x,df=7),type="l",xlab="test statistic",ylab="density",main="t-distribution wiht 7 deg. of freed.")


#---
# Plot range of rejection

alpha = 0.05
upper.bound = qt(1-alpha/2,df=7) 
lower.bound = -qt(1-alpha/2,df=7)

abline(v = c(lower.bound,upper.bound),col="darkred",lwd=2,lty=c(2,2))

#-
# plot test statistic
test.result = t.test(z, alternative = "two.sided",  conf.level = 0.95,var.equal=TRUE)

test.result$conf.int

Test.stat = test.result$statistic

abline(v = Test.stat,col="dodgerblue4",lwd=2)
text(-8,0.2,"obs. stat.",col="dodgerblue4")

2*pt(Test.stat,df=7)

#-----
bloodflow <- read_csv("~/Dropbox/Teaching/HS 2017/Applied BioStat I 2017 HS/Topics/data/bloodFlow.csv")

V <- sum(bloodflow$Caffeine > bloodflow$Baseline)
n = length(bloodflow$Caffeine)
binom.test(V, n, p = 0.5, alternative = "two.sided", conf.level = 0.95)

wilcox.test(bloodflow$Caffeine, bloodflow$Baseline, paired = TRUE, exact = TRUE, alternative = "two.sided", conf.level = 0.95)


#----
# t test

mao <- read.table("~/Dropbox/Teaching/HS 2017/Applied BioStat I 2017 HS/Topics/data/mao.dat",  sep="\t",header=T)
mao
x = mao$activity[mao$type==1]
y = mao$activity[mao$type==2]
par(mfrow=c(1,2))
hist(x,xlim=c(0,20))
hist(y,xlim=c(0,20))
t.test(x, y, alternative = "two.sided", paired = FALSE, conf.level = 0.95,var.equal=TRUE)
?t.test
var(x)
var(y)

test.result = t.test(x, y, alternative = "two.sided", paired = FALSE, conf.level = 0.95,var.equal=TRUE)


Test.stat = test.result$statistic
n = length(x)
m = length(y)

2*(1 - pt(Test.stat, n + m - 2))


### -----
#   Resampling in R:


mao <- read.table("~/Dropbox/Teaching/HS 2017/Applied BioStat I 2017 HS/Topics/data/mao.dat",  sep="\t",header=T)
mao
x = mao$activity[mao$type==1]
y = mao$activity[mao$type==2]
n=length(x)

set.seed(12)
xy.all <- c(x, y)
mean.diff <- function(group1) mean(xy.all[group1]) - mean(xy.all[-group1]) 
(D <- mean.diff(1:n))

N <- 1000
D.sample <- replicate(N,mean.diff(sample.int(n+m, size = n)))

hist(D.sample)
q.perm = quantile(p=c(0.025,0.975),D.sample)

abline(v=q.perm,col="red")
abline(v = D,lwd=2)
#------


library(perm)
permTS(x, y, alternative = "two.sided", paired = FALSE, conf.level = 0.95, method = "exact.mc")


#-----
# p value distirbution under H0


get.pvals.norm = function(reps,sample.size,mu,sigma) 
{
  p.vals = 1:reps
  for(i in 1 : reps)
    {
    test.vals = c(rnorm(sample.size/5,0,1),rep(0,4*sample.size/5))
    test = t.test(test.vals)
    p.vals[i] = test$p.value
    }
  
  return(p.vals)
}

p.vals = get.pvals.norm(reps = 10000 ,sample.size = 10,mu = 0,sigma = 1) 

hist(p.vals,ylab="Frequency",xlab="P-values")

