# load the file with the function to compute the D-stat
source("Dstat_Jacknife.r")

# read the data from the Simulated_Data
geno <- as.matrix(read.table("NeanderthalModel.geno", header=T, stringsAsFactors = F))
str(geno) # check what was read

# add a column with the genotypes of the outgroup
# that we assume if fixed to the ancestral allele
geno <- cbind(geno, 0)
# add column name to the 5th column
colnames(geno)[5] <- "chimp"
# check that geno matrix has the correct dimension
str(geno)

# individual names
inds <- colnames(geno)

# Population names in the order we want to compute the D-stat,
# that is, in the order P1, P2, P3, P4
# This is just a random order
pop.names <- 
  c("Africa", "Australia", "NeaPop2","chimp")


# Get the index of individuals from each population
# number of populations
npops <- length(pop.names)
# index of sampled individuals
sample_inds <- list() # list to save the index of individuals belonging to each pop
for(i in 1:npops) {
  # apply the function to detect which individuals belong to each pop
  sample_inds[[i]] <- which(substr(inds, 1, nchar(pop.names[i]))==pop.names[i])
}

# create a new genotype matrix ordered according to the sampled_inds
# That is a matrix with 4 columns corresponding to P1, P2, P3 and P4
# with an individual from each population
genoD <- geno[,sample_inds[[1]]]
for(i in 2:4) {
  genoD <- cbind(genoD, geno[,sample_inds[[i]]])
}
colnames(genoD) <- c(inds[sample_inds[[1]]],inds[sample_inds[[2]]],inds[sample_inds[[3]]],inds[sample_inds[[4]]]) 

# Need to get the index of individuals
# in this case since we have 1 individual per pop, the index is given by c(1,2,3,4)
ds <- dstat(genoD, index_inds = c(1:4))
ds$D # D-statistic
ds$abba # abba sites
ds$baba # abba sites

f4_aus <- ds$abba - ds$baba 

# REPEAT REPLACING AUSTRALIAN BY ANOTHER NEANDERTHAL
# This will  give us an expectation of 100% contribution

# Population names in the order we want to compute the D-stat,
# that is, in the order P1, P2, P3, P4
# This is just a random order
pop.names <- 
  c("Africa", "NeaAltai", "NeaPop2","chimp")


# Get the index of individuals from each population
# number of populations
npops <- length(pop.names)
# index of sampled individuals
sample_inds <- list() # list to save the index of individuals belonging to each pop
for(i in 1:npops) {
  # apply the function to detect which individuals belong to each pop
  sample_inds[[i]] <- which(substr(inds, 1, nchar(pop.names[i]))==pop.names[i])
}

# create a new genotype matrix ordered according to the sampled_inds
# That is a matrix with 4 columns corresponding to P1, P2, P3 and P4
# with an individual from each population
genoD <- geno[,sample_inds[[1]]]
for(i in 2:4) {
  genoD <- cbind(genoD, geno[,sample_inds[[i]]])
}
colnames(genoD) <- c(inds[sample_inds[[1]]],inds[sample_inds[[2]]],inds[sample_inds[[3]]],inds[sample_inds[[4]]]) 

# Need to get the index of individuals
# in this case since we have 1 individual per pop, the index is given by c(1,2,3,4)
ds <- dstat(genoD, index_inds = c(1:4))
ds$D # D-statistic
ds$abba # abba sites
ds$baba # abba sites

f4_nea <- ds$abba - ds$baba 

# Estimate of the admixture contribution
f4_aus/f4_nea
