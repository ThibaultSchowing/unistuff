# -------------------------------------------------------------------
# R course 2019
# Exercizes day 4
# -------------------------------------------------------------------

# Exercize 4.0 -------------------------------------------------------------------
# 
# a) Generate two random sequences seq1 and seq2 of 1000 numbers between 1 and 9
seq1 <- sample(1:9, 1000, replace = TRUE)
seq2 <- sample(1:9, 1000, replace = TRUE)

# b) Write a function compSeq that returns the number of positions at which seq1 and seq2 differ



compSeq <- function(seqa, seqb){
  return(length(which(seqa!=seqb)))
}

print(compSeq(seq1, seq2))

# Exercize 4.1 -------------------------------------------------------------------
# 
#  a) Program the factorial function n! = n*(n-1)*(n-2)*...*1 with a for loop
#


factorial <- function(n){
  if(n < 0){
    print("Enter positive number")
    return(FALSE)
  }
  if(n == 0){
    return(1)
  }
  f <- 1
  for (x in 1:n) {
    f <- f * x
  }
  return(f)
}


# Exercize 4.2 -------------------------------------------------------------------
# 
# Create a function called MDintoNA that converts missing data into NA from a data frame.
# The function parameters is the data frame and the character string coding for missing data.
# The output of the function is the modified data frame and the number of entries with missing data.
# Then apply your function to the file "StatWiSo2003.txt"

MDintoNA_corr <- function(dafr, md){
  na.count=sum(dafr==md)
  dafr[dafr==md]=NA
  list(na.count=na.count, df=dafr)
}


MDintoNA <- function(inputdf, md = "?"){
  # R arguments are not passed by reference
  # we'll return a copy of inputdf
  
  # Number of entries with missing data (md)
  nbmd <- 0
  # loop over all elements
  for(i in 1:nrow(inputdf)){
    for(j in 1:ncol(inputdf)){
      if(inputdf[i,j] == md){
        nbmd <- nbmd + 1
        # NA is a logical constant, not a string. 
        inputdf[i,j] <- NA
      }
    }
  }
  results <- list(inputdf, nbmd)
  return(results)
}

df <- read.csv("StatWiSo2003.txt", header = TRUE, sep = '\t')
df2 <- read.table("StatWiSo2003.txt", header=T)
summary(df)
# repl is a list containing the dataframe with NA instead of a string for missing data
# and the number of missing data
repl <- MDintoNA(df)
newdf <- repl[[1]]
nbNA <- repl[[2]]

asdf <- MDintoNA_corr(df2, "?")

# Exercize 4.3.----------------------------------

# Write the code to simulate rolling a dice 100 times and to count the number of 6's
# in as few instructions as possible

# Here we create a random sequence (rolling a dice 100 times) and count the number of 6's.
# note that we can't access the sequence here. To be able to access the sequence we should separate 
# the "sample" and "sum" functions. 
nb <- sum(sample(1:6, size = 100, replace = TRUE) == 6)

# Exercize 4.4 ----------------------------------
# 
# Implement a function "numheads" returning the number of heads obtained by tossing a coin n times
# 



numheads <- function(n){
  coin <- c("Head", "Tail")
  toss <- sample(coin, n, replace = TRUE)
  return(sum(toss == "Head"))
}



# Check that the number of heads r follows a binomial distribution with mean n/2
# For this, make a plot of the number of heads obtained by calling the function numheads 
# 10,000 times for n=50, and superimpose the corresponding binomial distribution of r

nbflips = 10000
n = 50

# create a vector of "nbflip" results of numhead(n) function
freq <- replicate(nbflips, numheads(n))

hist(freq, freq = FALSE, ylab = "Frequency", xlab = "Number of Heads")

# Create a sample of 50 numbers which are incremented by 1.
x <- seq(0,50,by = 1)

# Create the binomial distribution. (TutorialsPoint)
y <- dbinom(x,50,0.5)
lines(x, y)

plot(cumsum(freq) / 1:10000, lwd = 1, pch = 20)
abline(h = 25, col = "red")

#Exercise 4.5 ----------------------------------
# 
# a) Read the file "PolymSites10KbExpGrowth.txt", which contains the polymorphic 
#    positions found in 100 sequences of 10 Kb drawn from a recently exponentially 
#    growing population

dfseq <- read.csv("PolymSites10KbExpGrowth.txt", header = FALSE, stringsAsFactors = FALSE, sep = '\n')
# Instead of stringAsFactor=F we can set "what=character()
str(dfseq)
length(dfseq$V1)

# b) Import the function convertStringToCharVector contained in the file 
#    "ConvertStringToCharVector.r" and use it to convert the DNA sequences 
#    into arrays of single nucleotides

source("ConvertStringToCharVector.r")
#######CORRECTIONS

#numPolymSite=nchar(polymSite[1]); numPolymSite
#numSeq==length(polymSites);mumSeq
#polymSiteArray=array(dim=c(numSeqs, numPolymSite))

#for(i in 1:numSeqs) polymSiteArray[i,] = convertStringToCharVector(polymSite[i,])
#head(polymSiteArray)


########
#Create a list of vectors

lseq <- list()

for (i in 1:length(dfseq$V1)) {
  lseq[[i]] <- c(convertStringToCharVector(dfseq$V1[i]))
}
str(lseq)

 
# c) Write a function that returns the number of positions at which two vectors 
#    are different and use it to compute the number of differences between all the 
#    possble pairs of DNA sequences

# takes a list of vector as input
countDiff <- function(lstSeq){
  c <- combn(1:length(lstSeq), 2, simplify = FALSE)
  # c is a list of all possible paires
  
  totalDiff <- 0
  lstDiff <- list()
  
  for (p in c) {
    nbdif <- length(which(lstSeq[[p[1]]] != lstSeq[[p[2]]]))
    
    totalDiff = totalDiff + nbdif
    lstDiff <- c(lstDiff, nbdif)
  }
  print(totalDiff)
  return(unlist(lstDiff))
}

ldif <- countDiff(lseq)
str(ldif)



# 
# d) Plot the distribution of the number of differences, compute its mean and variance, 
#    and report on the graph the mean of the distribution in blue 

hist(ldif, breaks = seq(0,max(ldif),1), xlab = "Number of Pairwise Differences")
print(var(ldif))
abline(v = mean(ldif), col = "Blue", lwd=2)

