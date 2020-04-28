library("learnPopGen")
library("RColorBrewer")

help("drift.selection")

# Exercise 1 : Simulate evolution of a population due to genetic drift
# Pop size = 100, Generations = 50, Initial freq = 0.25

trajectory = drift.selection(p=0.25, Ne=100, ngen=50, nrep=1)
print(trajectory)


# Exercise 2; effect of decreasing or increasing Ne 

# Ne = 10

ne_10 = drift.selection(p=0.25, Ne=10, ngen=50, nrep=10)
ne_200 =drift.selection(p=0.25, Ne=200, ngen=50, nrep=10)

matrix = sapply(ne_10, function(x){x}, simplify = TRUE)
matrix = sapply(ne_10, function(x){x}, simplify = TRUE)

print(matrix)
try = which(matrix[,1]==0)
print(try[1])

# As ne decreases, the probability of loosing an allele increases 
lost = 0
fixed = 0
for (ne in seq(100,500, by=100)) {
  list = drift.selection(p=0.25, Ne=ne, ngen=200, nrep=10)
  matrix = sapply(list, function(x){x}, simplify = TRUE)
  if (any(matrix[,1]==0)){
    lost = lost +1 
  } 
  if (any(matrix[,1]==1)){
    fixed = fixed+1
  }
  meanfreq = rowMeans(matrix)
  lines(0:200, meanfreq, lwd=3, lty=3, col="black")
}
print(lost)
print(fixed)

# Increasing Ne doesn't really increase the chance of fixation if initial allele frequency and fitness stay the same 


# Exercise 3 : chaning NE 
lost = 0
fixed = 0
for (ne in seq(10,500, by=20)) {
  f = 1/(2*ne)
  list = drift.selection(p=f, Ne=ne, ngen=200, nrep=10)
  matrix = sapply(list, function(x){x}, simplify = TRUE)
  if (any(matrix[,1]==0)){
    lost = lost +1 
    print("lost at ne of")
    print(ne)
    print("lost at generation")
    lost_at = which(matrix[,1]==0)
    print(lost_at[1])
  } 
  if (any(matrix[,1]==1)){
    fixed = fixed+1
    print("fixed at ne of")
    print(ne)
    print("fixed at generation")
    fixed_at = which(matrix[,1]==1)
    print(fixed_at[1])
  }
  meanfreq = rowMeans(matrix)
  lines(0:200, meanfreq, lwd=3, lty=3, col="black")
}
print(lost)
print(fixed)

# Such a small Ne makes it really likely to loose the allele 

# Exercise 3: changing po
lost = 0
fixed = 0
ne = 200
for (f in seq(0,1, by=0.1)) {
  list = drift.selection(p=f, Ne=ne, ngen=200, nrep=10)
  matrix = sapply(list, function(x){x}, simplify = TRUE)
  if (any(matrix[,1]==0)){
    lost = lost +1 
    print("lost at p0 of")
    print(f)
    print("lost at generation")
    lost_at = which(matrix[,1]==0)
    print(lost_at[1])
  } 
  if (any(matrix[,1]==1)){
    fixed = fixed+1
    print("fixed at p0 of")
    print(f)
    print("fixed at generation")
    fixed_at = which(matrix[,1]==1)
    print(fixed_at[1])
  }
  meanfreq = rowMeans(matrix)
  lines(0:200, meanfreq, lwd=3, lty=3, col="black")
}
print(lost)
print(fixed)



# Exercise 4 

size = 10
h = 0.5
s = 0.2
relFitness = c(1+s, 1+(h*s), 1)
initFreq= 0.25
time = 100

sel_snp = drift.selection(p0=initFreq, Ne=size, w=relFitness, nrep = 1, ngen=time, show="p")
sel_snp = sapply(sel_snp, function(x) {x}, simplify = TRUE)
meanfreq_sel = rowMeans(sel_snp)
lines(0:time, meanfreq_sel, lwd=3, lty=3, col="black")

# Compare trajectories with p = 1/2ne 
# h = 0.5 and s = 0.05
# of populations 10 and 200 
size = 10
h = 0.5
s = 0.05
relFitness = c(1+s, 1+(h*s), 1)
initFreq = 1/(2*size) 
time=100

sel_snp = drift.selection(p0=initFreq, Ne=size, w=relFitness, nrep = 100, ngen=time, show="p")
sel_snp = sapply(sel_snp, function(x) {x}, simplify = TRUE)
meanfreq_sel = rowMeans(sel_snp)
lines(0:time, meanfreq_sel, lwd=3, lty=3, col="black")

size = 200
h = 0.5
s = 0.0.5
relFitness = c(1+s, 1+(h*s), 1)
initFreq = 1/(2*size) 
time=100

sel_snp = drift.selection(p0=initFreq, Ne=size, w=relFitness, nrep = 100, ngen=time, show="p")
sel_snp = sapply(sel_snp, function(x) {x}, simplify = TRUE)
meanfreq_sel = rowMeans(sel_snp)
lines(0:time, meanfreq_sel, lwd=3, lty=3, col="black")


# Consider different values of s 
ne = 10
lost = 0
fixed = 0
for (s in seq(0,0.5,by=0.01)){
  p = 1/(2*ne)
  relFitness = c(1+s, 1+(h*s), 1)
  sel_snp = drift.selection(p0=p, Ne=size, w=relFitness, nrep = 10, ngen=time, show="p")
  sel_snp = sapply(sel_snp, function(x) {x}, simplify = TRUE)
  if (any(sel_snp[,1]==0)){
    lost = lost +1 
    print("lost at s of")
    print(s)
    print("lost at generation")
    lost_at = which(sel_snp[,1]==0)
    print(lost_at[1])
  } 
  if (any(sel_snp[,1]==1)){
    fixed = fixed+1
    print("fixed at s of")
    print(s)
    print("fixed at generation")
    fixed_at = which(sel_snp[,1]==1)
    print(fixed_at[1])
  }
  meanfreq = rowMeans(sel_snp)
  lines(0:100, meanfreq, lwd=3, lty=3, col="black")
}
print(lost)
print(fixed)


# Consider different values of ne and s 
lost = 0
fixed = 0
for (s in seq(0,0.5,by=0.01)){
  relFitness = c(1+s, 1+(h*s), 1)
  for (ne in seq(50,500,by=50)){
    p = 1/(2*ne)
    sel_snp = drift.selection(p0=p, Ne=ne, w=relFitness, nrep = 10, ngen=time, show="p")
    sel_snp = sapply(sel_snp, function(x) {x}, simplify = TRUE)
    if (any(sel_snp[,1]==0)){
      lost = lost +1 
      print("lost at ne of")
      print(ne)
      print("at s of")
      print(s)
      print("lost at generation")
      lost_at = which(sel_snp[,1]==0)
      print(lost_at[1])
    } 
    if (any(sel_snp[,1]==1)){
      fixed = fixed+1
      print("lost at ne of")
      print(ne)
      print("fixed at s of")
      print(s)
      print("fixed at generation")
      fixed_at = which(sel_snp[,1]==1)
      print(fixed_at[1])
    }
    meanfreq = rowMeans(sel_snp)
    lines(0:100, meanfreq, lwd=3, lty=3, col="black")
  }
}
  
print(lost)
print(fixed)


# Exercise 6 
founder.event(p0 = 0.5, Ne=100, Nf=10, ttime=200, etime=50:70, show="p")




