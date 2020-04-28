
# Perform the D-statistics analysis based on single individuals
# INPUT
#   genotypes : matrix with nsites*4, where each column corresponds to the genotype of a given individual
#               the order of individuals is P1, P2, P3, Outgroup
#   index_ind : vector with 4 entries with the index of individuals for the four pops
#               e.g. c(1,2,3,6) means that the 1st individual corresponds to P1, 2nd individual to P2
#                               3rd-5th individual to P3, and 6th to last individual to P4
# RETURN
#   numeric value with the D-statistic value.
dstat <- function(genotypes, index_inds) {
  
  # add a last element for the index_inds
  index_inds <- c(index_inds, index_inds[length(index_inds)]+1)
  # look at sites without missing data for each pop
  # obtain the sample size for each site for each population
  ssp <- list() # list saving the sample size for each pop that has no missing data across populations
  for(i in 1:4) {
    ssp[[i]] <- rowSums(!is.na(genotypes[,index_inds[i]:(index_inds[i+1]-1), drop=F]))
    index_goodsites <- which(ssp[[i]]>0)
    genotypes <- genotypes[index_goodsites,]
    # str(genotypes)
    for(j in 1:i) {
      ssp[[j]] <- ssp[[j]][index_goodsites]  
    }
  }
  
  # list with the allele frequencies for each site and each pop
  p <- matrix(NA,nrow=nrow(genotypes), ncol=4)
  for(i in 1:4) {
    p[,i] <- rowSums(genotypes[,index_inds[i]:(index_inds[i+1]-1), drop=F], na.rm=T)/(2*ssp[[i]])  
  }
  
  # compute abba
  abba <- (1-p[,1])*p[,2]*p[,3]*(1-p[,4])
  baba <- p[,1]*(1-p[,2])*p[,3]*(1-p[,4])
  
  D <- (sum(abba)-sum(baba))/(sum(abba)+sum(baba))
  list(D=D, abba=sum(abba), baba=sum(baba))
}

# DJACK
# compute the D-statistic and perform the jacknife approach to test for significant differences from zero
# INPUT
#  numblocks : integer with number of blocks (the dataset is divided into blocks with similar #SNPs)
#  genotypes : matrix with nsites*4, where each column corresponds to the genotype of a given individual
#               the order of individuals is P1, P2, P3, Outgroup
#   index_ind : vector with 4 entries with the index of individuals for the four pops
#               e.g. c(1,2,3,6) means that the 1st individual corresponds to P1, 2nd individual to P2
#                               3rd-5th individual to P3, and 6th to last individual to P4
# OUTPUT
#  list with the results
Djack <- function(genotypes, index_inds, numblocks) {

  # Jackknife approach - compute psi by removing a block of blocksize snps at a time
  blocksize <- round(nrow(genotypes)/numblocks)
  
  # define auxiliary variables with index of SNPs according to the block
  aux_start <- seq(1, nrow(genotypes), by=blocksize)
  aux_end <- c(aux_start[2:length(aux_start)]-1, nrow(genotypes))
  mat <- cbind(aux_start, aux_end)

  # Check if last block has at least 50% of SNPs
  # if not, put it together with the previous block
  if(aux_end[nrow(mat)]-aux_start[nrow(mat)] < (0.5*blocksize)) {
    # if true, join the block with previous one
    mat <- mat[-nrow(mat),]
    mat[nrow(mat),2] <- aux_end[length(aux_end)] 
  }
  # update number of blocks
  numblocks <- nrow(mat)
  
  # compute D-stat with all data
  ds <- dstat(genotypes, index_inds)$D
  
  # compute the D-stat removing a block at a time
  psi <- apply(mat, 1, function(x) {dstat(genotypes[-c(x[1]:x[2]),], index_inds)$D})
  # compute the mean D-stat of the jackknife 
  psmean <- mean(psi)
  # compute the variance D-stat of the jackknife correcting for number of blocks
  psvar <- ((numblocks-1)/numblocks)*sum((psi-psmean)^2)
  # compute the standard deviation D-stat of the jackknife 
  sdps <- sqrt(psvar)
  # compute the z-score, assuming that D follows a normal distribution with mean 0 and sd given by sdps
  zscore <- ds/sdps
  
  # Using the formula from http://datadryad.org/bitstream/handle/10255/dryad.53348/auto_ABBA_BABA_jackknife.r?sequence=1
  D_pseudo <- (ds*numblocks) - (psi*(numblocks-1))
  D_err <- sqrt(var(D_pseudo)/numblocks)
  zscore2 <- ds / D_err
  # results in exactly the same!
  
  list(D=ds, sd=sdps, z=zscore, z2=zscore2)  
}

# FUNCTION TO ADD ERROR BARS TO PLOTS
add.error.bars <- function(X,Y,SE,w,col=1){
  X0 = X; Y0 = (Y-SE); X1 =X; Y1 = (Y+SE);
  arrows(X0, Y0, X1, Y1, code=3,angle=90,length=w,col=col);
}
