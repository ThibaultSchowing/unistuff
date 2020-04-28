# Day 2 - Drift and selection
# practical session 1

library("learnPopGen")
library("RColorBrewer")

# Use variables to save the settings
eSize <- 100 # effective size
relFitness <- c(1,1,1) # relative fitness of DD, AD, AA genotypes, where A is the ancestral allele and D is the derived allele
initFreq <- 0.1 # initial frequency of derived allele D at time zero 
time <- 100 # number of generations

# Simulate 1 SNP locus
neutral_snp <- drift.selection(p0=initFreq, Ne=eSize, w=relFitness, nrep=1, ngen=time, show="p") 
# Simulate 10 SNP loci using 10 colors generated with R Color Brewer
mycol <- brewer.pal(n=10, name = "Paired")
neutral_snp <- drift.selection(p0=initFreq, Ne=eSize, w=relFitness, nrep=10, ngen=time, show="p", colors = mycol[1:10]) 

# Convert the list with output of the 10 simulations to a matrix
# where each column is an independent simulation, and each row is a generation
neutral_snp <- sapply(neutral_snp, function(x) {x}, simplify=TRUE)

# Compute the mean frequency at each generation across simulations
meanfreq_neutral <- rowMeans(neutral_snp)
# Add a line with the mean frequency
lines(0:time, meanfreq_neutral, lwd=3, lty=3, col="black")




