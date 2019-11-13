# -------------------------------------------------------------------
# R course 2019
# Exercizes day 4
# -------------------------------------------------------------------

# Exercize 4.0 -------------------------------------------------------------------
# 
# a) Generate two random sequences seq1 and seq2 of 1000 numbers between 1 and 9
seq1 <- sample(1:9, size=1000, replace=TRUE); seq1
str(seq1)
seq2 <- sample(1:9, size=1000, replace=TRUE); seq2
s1=table(seq1);s1
plot(s1)
s2=table(seq2);s2
plot(s2)

# b) Write a function compSeq that returns the number of positions at which seq1 and seq2 differ

# INPUT
#   v1 : vector with numbers
#   v2 : vector with numbers
# NOTE: v1 and v2 must have the same size
# OUTPUT
#    number with the number of differences 
getNumDiffs <- function(v1, v2) {
  # diffs <- v1 != v2
  # sum(diffs)
  sum(v1 != v2)
  # other solution
  #length(which(diffs))
} 

# now, lets call the function with seq1 and seq2
getNumDiffs(v1=seq1, v2=seq2)
getNumDiffs(seq1, seq2)



# Exercize 4.1 -------------------------------------------------------------------
# 
#  a) Program the factorial function n! = n*(n-1)*(n-2)*...*1 with a for loop
#  
fact1<-function(n) {
  fact=1
  for (i in 2:n) {
    fact=fact*i
  }
  return(fact)
}
fact1(5)

#  b) Program the factorial function with the function prod
fact2<-function(n) prod(1:n)
fact2(5)

# Exercize 4.2 -------------------------------------------------------------------
# 
# Create a function called MDintoNA that converts missing data into NA from a data frame.
# The function parameters is the data frame and the character string coding for missing data.
# The output of the function is the modified data frame and the number of entries with missing data.
# Then apply your function to the file "StatWiSo2003.txt"

MDintoNA<-function(dafr, md) {
	na.count=sum(dafr==md)
	dafr[dafr==md]=NA
   list(na.count=na.count, df=dafr)
}

df=read.table("StatWiSo2003.txt", header=T)
df2=read.table("StatWiSo2003.txt", header=T, na.strings="?")
df[1:20,]
df2=MDintoNA(dafr=df,md="?")
df2$na.count
df2$df[1:20,]
df2[1:20,]


# Exercize 4.3.----------------------------------

# Write the code to simulate rolling a dice 100 times and to count the number of 6's
# in as few instructions as possible

diceRolls=sample(1:6,100, replace=T)
sum(diceRolls==6)
diceRolls==6
sum(sample(1:6,100, replace=T)==6)

# Exercize 4.4 ----------------------------------
# 
# Implement a function "numheads" returning the number of heads obtained by tossing a coin n times

numheads<-function(n) {
  r=sample(0:1, n, replace=T)
  sum(r)
}
numheads(100)
rbinom(1, 100, prob = 0.5)

# 
# Check that the number of heads r follows a binomial distribution with mean n/2
# For this, make a plot of the number of heads obtained by calling the function numheads 
# 10,000 times for n=50, and superimpose the corresponding binomial distribution of r

distrNumHeads<-function(numrep, numtoss) {
  res=array(0,dim=numrep)
  for (i in 1:numrep) {
    res[i]=numheads(numtoss)
  }
  return(res)
}
heads=distrNumHeads(numrep=numrep,numtoss=n)
table(heads)
n=50
r=0:n
numrep=10000
binom.distr=dbinom(r, size=n, prob=0.5)
num.heads=table(distrNumHeads(numrep=numrep,numtoss=n))/numrep
maxy=max( max(binom.distr), max(num.heads) )

# plot(num.heads, lwd=4, col="blue",xlim=c(-0.5,n+0.5), ylim=c(0,maxy), xlab="r", ylab="Prob(X=r)")
plot(num.heads, lwd=4, col="blue", ylim=c(0,maxy), xlab="r", ylab="Prob(X=r)")
#Use curve to plot a predefined function
# curve(dbinom(x, size=n, prob=0.5), from=0, to=n, n=n+1, add=T, lwd=2)
#Here use plot(type="p") as it is a discrete function
lines(0:n, dbinom(x=0:n, size=n, prob=0.5), lwd=2, type="p", col="red", pch=16)

# Check that we also have a good fit with a Normal distribution with mean n*p and variance n*p*(1-p)
curve(dnorm(x, mean=n*0.5, sd=sqrt(n*0.5*0.5)), from=0, to=n, n=200, add=T, lwd=2, col="red")

#Exercise 4.5 ----------------------------------
# 
# a) Read the file "PolymSites10KbExpGrowth.txt", which contains the polymorphic 
#    positions found in 100 sequences of 10 Kb drawn from a recently exponentially 
#    growing population

#Reading polymorphic sites of a 100Kb DNA sequences
polymSites=scan("PolymSites10KbExpGrowth.txt", what=character());polymSites
str(polymSites)
polymSites2=read.table("PolymSites10KbExpGrowth.txt",stringsAsFactors = F);polymSites2
str(polymSites2)
# polymSites2=as.matrix(read.table("PolymSites10KbExpGrowth.txt")) #works as well



# b) Import the function convertStringToCharVector contained in the file 
#    "ConvertStringToCharVector.r" and use it to convert the DNA sequences 
#    into arrays of single nucleotides

#Import function
source("ConvertStringToCharVector.r")
#Creating array to host the vector of polymorphic nucleotides
numPolymSites=nchar(polymSites[1]); numPolymSites
numSeqs=length(polymSites);numSeqs 
polymSiteArray=array(dim=c(numSeqs,numPolymSites))
for(i in 1:numSeqs) polymSiteArray[i,] = convertStringToCharVector(polymSites[i])
head(polymSiteArray)
# 
# c) Write a function that returns the number of positions at which two vectors 
#    are different and use it to compute the number of differences between all the 
#    possble pairs of DNA sequences

computeNumDiffsBetweenSequences=function(seq1, seq2) {
  sum(seq1!=seq2)
}

#Computing the distribution of the number of pairwise differences between DNA sequences
count=0
diffDistr=vector(length=numSeqs*(numSeqs-1)/2)
for(i in 1:numSeqs) {
  for (j in 1:numSeqs) if (j<i) {    
    count=count+1
    diffDistr[count]=computeNumDiffsBetweenSequences(polymSiteArray[i,], polymSiteArray[j,])
  }
}
table(diffDistr)

# 
# d) Plot the distribution of the number of differences, compute its mean and variance, 
#    and report on the graph the mean of the distribution in blue 

#Plotting distribution of the number of pairwise differences
hist(diffDistr, nclass=max(diffDistr)+1, main="Distribution of pairwise differences between DNA sequences", 
     xlab="No. of differences between pairs of sequences")
meandiff=mean(diffDistr)
vardiff=var(diffDistr)
abline(v=meandiff, col="blue", lwd=2)


#The distribution is unimodal, and its mean is proportional to the age of the population expansion, 
#scaled by the mutation rate


