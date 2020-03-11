library(scrm)
library(ape)

# SIM.TREE
# call sim.tree function to simulate gene trees
## This is to simulate a coalescent tree using the generation (discrete time) approximation algorithm, with 20 sampled lineages.
## In this example, the population size is 1000
# INPUT 
#   sample - number of lineages sampled. For instance, if 2 diploid individuals, sample=4.
#   current - number with current effective size (in number of diploids)
#   ancestral - number with ancestral effective size (in number of diploids)
#   time - number with time in generations ago of size change from ancestral to current
#   nrep - number of independent loci simulated
# OUTPUT
#   object of scrm with trees and segregating sites
sim.tree <- function(sample = 4,
                     current = 1000, 
                     ancestral=1000, 
                     time=0, nrep=1) {
  
  Nref <- current
  relA <- ancestral/Nref
  tchange <- time/(4*Nref)
  theta <- 4*Nref*1
  
  sum_stats <- scrm(paste(sample, nrep, '-t', theta ,'-T -eN', tchange, relA))
  sum_stats
}

# DRAW.TREE
## This plots (on the screen) the coalescent tree, with labels
# INPUT 
#   tree - object output from sim.tree
#   nrep - number of loci, i.e. independent simulations
#   events - value with scaled time of how long ago an event happened
# OUTPUT
#   draw trees with time measured in current Ne units, i.e. 1 unit is 4*Ne generations
draw.tree <- function(tree, nrep=1, events=-10) {
  # read the trees with ape package read.tree function
  trees <- read.tree(text = paste0(unlist(tree$trees)))
  
  if(nrep==1) {
    plot(trees, no.margin = FALSE)
    # add axis to tree
    axisPhylo()  
    
    # get the coalescent times
    coal_int <- coalescent.intervals(trees)
    tmrca <- sum(coal_int$interval.length)
    
    # add line of events
    abline(v=tmrca-events, col=4)
  } else if(nrep>1) {
    for(i in 1:length(trees)) {
      # plot the trees
      plot(trees[i], no.margin = FALSE)
      # add axis to tree
      axisPhylo()  
      
      # get the coalescent times
      coal_int <- coalescent.intervals(trees[[i]])
      tmrca <- sum(coal_int$interval.length)
      
      # add line of events
      abline(v=tmrca-events, col=4)
    }
  }
}

# COALTIMES
## Outputs coalescent times
# INPUT 
#   tree - object output from sim.tree
#   nrep - number of loci, i.e. independent simulations
# OUTPUT
#   matrix with each row corresponding to a coalescent interval
#   and each column to a simulation. The 1st column has the
#   number of lineages in each interval. NOTE: time scaled 
#   in units of 4*currentNe.
coaltimes <- function(tree, nrep=1) {
  # read the trees with ape package read.tree function
  trees <- read.tree(text = paste0(unlist(tree$trees)))
  
  if(nrep==1) {
    tmp <- coalescent.intervals(trees)
    coal_int <- matrix(NA, nrow=tmp$interval.count, ncol=2)
    coal_int[,1] <- tmp$lineages
    # get the coalescent times
    coal_int[,2] <- coalescent.intervals(trees)$interval.length
  } else if(nrep>1) {
    tmp <- coalescent.intervals(trees[[1]])
    coal_int <- matrix(NA, nrow=tmp$interval.count, ncol=length(trees)+1)
    coal_int[,1] <- tmp$lineages
    for(i in 1:length(trees)) {
      # get the coalescent times
      coal_int[,i+1] <- coalescent.intervals(trees[[i]])$interval.length
    }
  }
  coal_int
}


# SIM.TREE.MUT
## Simulates trees and adds mutations
# INPUT 
#   sample - number of lineages sampled. For instance, if 2 diploid individuals, sample=4.
#   current - number with current effective size (in number of diploids)
#   ancestral - number with ancestral effective size (in number of diploids)
#   time - number with time in generations ago of size change from ancestral to current
#   nrep - number of independent loci simulated
#   mu - number with mutation rate per site
#   L - integer number with number of sites 
# OUTPUT
#   matrix with each row corresponding to a coalescent interval
#   and each column to a simulation. The 1st column has the
#   number of lineages in each interval. NOTE: time scaled 
#   in units of 4*currentNe.
sim.tree.mut <- function(sample = 4,
                         current = 1000, 
                         ancestral=1000, 
                         time=0, nrep=1, 
                         mu=1e-8, L=1e4) {
  
  Nref <- current
  relA <- ancestral/Nref
  tchange <- time/(4*Nref)
  theta <- 4*Nref*L*mu
  sum_stats <- scrm(paste(sample, nrep, '-t', theta ,'-T -eN', tchange, relA))
  sum_stats
}


# PLOT.HAPLOTYPES
## This plots (on the screen) the coalescent tree, with labels
# INPUT 
#   tree - object output from sim.tree
#   nrep - number of loci, i.e. independent simulations
#   L    - integer number with number of sites
# OUTPUT
#   draw trees with time measured in current Ne units, i.e. 1 unit is 4*Ne generations
plot.haplotypes <- function(tree, nrep=1) {
  # read the trees with ape package read.tree function
  trees <- read.tree(text = paste0(unlist(tree$trees)))
  
  if(nrep==1) {
    par(mfrow=c(1,2))
    # plot gene tree  
    plot(trees, no.margin = FALSE)
    # add axis to tree
    axisPhylo()  
    
    # plot the SNPs
    # get the haplotypes
    hap <- tree$seg_sites[[1]]
    label <- as.numeric(trees$tip.label)
    # tmp <- matrix(0,ncol=L, nrow=nrow(hap))
    # tmp[,round(as.numeric(colnames(hap))*L)]  <- hap[as.numeric(trees$tip.label),]
    # image(x=1:ncol(tmp), y=1:nrow(tmp), t(tmp), ylab="lineages (inds)", xlab="sites")
    image(x=1:ncol(hap), y=1:nrow(hap), t(hap[label,]), ylab="lineages (inds)", xlab="SNPs", axes=FALSE)
    
  } else if(nrep>1) {
    for(i in 1:nrep) {
      par(mfrow=c(1,2))
      # plot the trees
      plot(trees[[i]], no.margin = FALSE)
      # add axis to tree
      axisPhylo()  
      # plot the SNPs
      # get the haplotypes
      hap <- tree$seg_sites[[i]]
      label <- as.numeric(trees[[i]]$tip.label)
      # tmp <- matrix(0,ncol=L, nrow=nrow(hap))
      # tmp[,round(as.numeric(colnames(hap))*L)]  <- hap[as.numeric(trees$tip.label),]
      # image(x=1:ncol(tmp), y=1:nrow(tmp), t(tmp), ylab="lineages (inds)", xlab="sites")
      image(x=1:ncol(hap), y=1:nrow(hap), t(hap[label,]), ylab="lineages (inds)", xlab="SNPs", axes=FALSE)
    }
  }
}

