library(SNPRelate)

# read the genotype matrix
geno <- as.matrix(read.table("TestGenomeScan.geno", header=T, stringsAsFactors = F, na.strings = "NA"))
# check if we read genotype matrix correctly
str(geno) # matrix with nsites rows and nind columns
# How many individuals? How many sites?

# get the label of the individuals
inds <- colnames(geno)

# vector with the population name
pop.names <- c("Pop1", "Pop2")
npops <- length(pop.names) 

# A way to get this for all populations
# go through each pop.name and get the index of individuals of each pop 
sample_inds <- list() # list to save the index of individuals belonging to each pop
for(i in 1:length(pop.names)) {
  # apply the function to detect which individuals belong to each pop
  sample_inds[[i]] <- which(substr(inds, 1, nchar(pop.names[i]))==pop.names[i])
}

# create tag 
# this string will be added to the files saved by SNPrelate
filename_tag <- "GenomeScan"

# create a vector with the population corresponding to each individual
popinds <- names(geno) # initiliaze this with the individual names
for(i in 1:length(pop.names)) {
  # get pop.name label for individuals belonging to a given pop
  popinds[sample_inds[[i]]] <- pop.names[i]
}

# SNP relate - WINDOW SCAN
# create input geno file for package
filename_geno <- paste(filename_tag,"_geno.gds",sep="")
# use the package function, giving as input:
# - genmatrix is the genotype matrix "geno"
# - sample.id is the name of individuals in variable "inds"
snpgdsCreateGeno(gds.fn=filename_geno, genmat=geno, snpfirstdim=TRUE, sample.id=inds)

# Open the GDS file that you just created
# this GDS file is the format used by SNPrelate
genofile <- snpgdsOpen(filename=filename_geno)

# SCAN THE GENOME FOR FST AND EXPECTED HETEROZYGOSITY
# Compute the pairwise FST in a sliding window analysis using function snpgdsFst
windowSize <- 100
WindowShift <- 50
fst_sw <- list() # list to save the sliding window FST values for each pair of populations
allfreq_sw <- list() # list to save the sliding window allele frequency values
# go through each pair of populations
for(i in 1:(length(pop.names))) {
  fst_sw[[i]] <- list()
  if(i < length(pop.names)) {
    for(j in (i+1):length(pop.names)) {
      # select individuals from the two populations
      keepfst <- popinds==pop.names[i] | popinds==pop.names[j] 
      # Perform a sliding windon analysis of FST
      fst_sw[[i]][[j]] <- snpgdsSlidingWindow(genofile, winsize=windowSize, shift=WindowShift, FUN="snpgdsFst", as.is="numeric", sample.id=inds[keepfst], population=as.factor(popinds[keepfst]))
    }  
  }
  # perform the sliding window analysis to get the allele frequencies
  allfreq_sw[[i]] <- snpgdsSlidingWindow(genofile, winsize=windowSize, shift=WindowShift, snp.id=NULL, remove.monosnp=FALSE,
                                         FUN="snpgdsSNPRateFreq", as.is="numeric", sample.id = inds[sample_inds[[i]]])
  
}

# Plot the heterozygosity along the chromosome
# from the allele frequencies obtain expected heterozygosity
exp_het <- matrix(NA, ncol=length(allfreq_sw[[1]]$chr1.val), nrow=npops)
for(i in 1:npops) {
  exp_het[i,] <- (2*allfreq_sw[[i]]$chr1.val)-(2*allfreq_sw[[i]]$chr1.val^2)
}  
# plot the expected heterozygosity for each population  
plot(exp_het[1,], type="l", ylim=c(0,0.4), ylab="Expected heterozygosity", xlab="SNP position (index)")
for(i in 2:(length(pop.names))) {
  lines(exp_het[i,], type="l", col=2)
}

# Plot the pairwise FST value
par(mfrow=c(1,1))
plot(fst_sw[[1]][[2]]$chr1.val, type="l", ylim=c(-0.1,0.6), xlab="SNP position", ylab="FST")

# look at the distribution of FST to find the 5% quantile
hist(fst_sw[[1]][[2]]$chr1.val, main="distribution of FST", xlab="FST")
thresholdFst_95 <- quantile(fst_sw[[1]][[2]]$chr1.val, 0.95)
thresholdFst_99 <- quantile(fst_sw[[1]][[2]]$chr1.val, 0.99)

abline(h=thresholdFst_95, lty=3)
abline(h=thresholdFst_99, lty=3, col="red")


# Close the GDS file
snpgdsClose(genofile)
